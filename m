Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8DCC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 11:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0f4u-0006yw-9p; Fri, 04 Apr 2025 07:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0f4k-0006rk-2d
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0f4e-0005Zn-8E
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743765538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lQEzuxCJJ4p6FaAnKCeul5m9P3sP81qH+65oTWTun0=;
 b=CU1RXOX5E3VqzZYIYnuewYtc0e4NlaJDU+Y7UnAZujvQyuy2kNDMDtN82OCOkLMssVmHn/
 9AN2yfJYIi1XnQc2pSHkx97keWLWSLm4DMkgqZoN2zIl/jYSvJFkSaVlcTL+g7LT3FZKMV
 rTSy31mvf3oc0z4ApKNh1b4If6zAq4s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-E7o5lTMlN-yArOCZi2oASg-1; Fri, 04 Apr 2025 07:18:53 -0400
X-MC-Unique: E7o5lTMlN-yArOCZi2oASg-1
X-Mimecast-MFC-AGG-ID: E7o5lTMlN-yArOCZi2oASg_1743765532
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ceeaf1524so11269935e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 04:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743765532; x=1744370332;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6lQEzuxCJJ4p6FaAnKCeul5m9P3sP81qH+65oTWTun0=;
 b=ry0cVolDXop2JrGaE2kBCCdWCqOIFdk4vA2stH7IB/jYuCNDywh5CDtODt+cvfJca7
 Zxik5nmTDB/Jxx3OkM3MeAg1Sj0KdOcAkCG387XZkYlSL64FfuRbXLwtKfJnloDepzjI
 C2vXHlYpYNwHAjxsv8wiTl26GC2WXRSO5PQ57fuC2ciVpQH3aeDi5UIw1sNXafU9neOK
 hrq1arglNOHlo5eizPpLrSUV1M4ADPwq/TgVtq04zqnMnRE2xV+YXRB1fvjNBpADBMOF
 BVdH9N4xSJNrh1/Es28FBLU9LSoc4xoK2gdRt7BzNE386nuGAAhrH/DELLf5aALehhET
 mH3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYv4oQodSu2mOQv8sLjS3xAVjrHdddOnw6UG9GvJVLxotp7CkLhrYFyFr+B97csNwHk64EJOM7yWA6@nongnu.org
X-Gm-Message-State: AOJu0Yy+1HbDGnfLtN6qlZoSLgEoccjxwH4/sPVrjnuDT3alcYX0hfXv
 z7ZALWuWPyDJpYNNcfp1ltXP4psUJd3YR99JIGwZGsrE4y2agxrnnxSSc7yan9FpNSrj+fX0wsm
 FSL+sQp+oZAnGUkdrbiUfKwOHRmxnpPqWGVw4Tp8VLpb0YXEqdu9m
X-Gm-Gg: ASbGnctIXo9QKsqtlH0WG3VDWRGkVUxYt5JHstfyTlQxiKHBVw6D+S0uT0VPGSY4WRS
 RWpu0ndUw+Ps6hhh/IoIQfm4Zy2fErRJwDroDS52AE86Ofv3hNF4Ha+UtT8XA/+krXzVhaLhVPM
 ARVcyYaFVgbn1YuTSKyNCEFBmn+ceP1z0OQ746p+TVL+7nuLYQlqauMh3ShrW5p94XQcrdzfcN5
 +37X+GE7SvacfK8fFs7++ew7EzsPyNXhbXPL9KhB7+EjzutEvXBD4vI1G/j6qKEiiC8STbHAFxD
 ljvMjPyeKXX2PxgDbZJdfNP6oSmunneWPPp3lOXb1QUzWQUPyGVLR/ObSxXKAjmgtOWQ4ddIJUg
 C+ZOcEXFqxQ62W5g5LaqNrDt9bWwuMAwHcZf1UpZFRXt+
X-Received: by 2002:a05:600c:6990:b0:439:873a:1114 with SMTP id
 5b1f17b1804b1-43ecedc1cb8mr28060185e9.6.1743765531963; 
 Fri, 04 Apr 2025 04:18:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKMxNcFjS1zPG/KsoMA3pLd/Atkvr8Q8Y0GKfsGb1U51T+X0ImV6BA+SbwZOyx4rHuG+IRjA==
X-Received: by 2002:a05:600c:6990:b0:439:873a:1114 with SMTP id
 5b1f17b1804b1-43ecedc1cb8mr28059935e9.6.1743765531634; 
 Fri, 04 Apr 2025 04:18:51 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74f:9d66:d61a:f3cf:3494:9981?
 (p200300cfd74f9d66d61af3cf34949981.dip0.t-ipconnect.de.
 [2003:cf:d74f:9d66:d61a:f3cf:3494:9981])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec342a3dfsm43829835e9.4.2025.04.04.04.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 04:18:50 -0700 (PDT)
Message-ID: <4ff15202-e375-4618-a756-4411968699f8@redhat.com>
Date: Fri, 4 Apr 2025 13:18:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] fuse: Copy write buffer content before polling
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160635.118812-1-hreitz@redhat.com>
 <re2wbm3hv4tqymmyan2rovwvxvfayh4rkyzn6ckjuoqlysmyjb@iscof2qe4fvg>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <re2wbm3hv4tqymmyan2rovwvxvfayh4rkyzn6ckjuoqlysmyjb@iscof2qe4fvg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 01.04.25 15:44, Eric Blake wrote:
> On Tue, Mar 25, 2025 at 05:06:35PM +0100, Hanna Czenczek wrote:
>> Polling in I/O functions can lead to nested read_from_fuse_export()
>> calls, overwriting the request buffer's content.  The only function
>> affected by this is fuse_write(), which therefore must use a bounce
>> buffer or corruption may occur.
>>
>> Note that in addition we do not know whether libfuse-internal structures
>> can cope with this nesting, and even if we did, we probably cannot rely
>> on it in the future.  This is the main reason why we want to remove
>> libfuse from the I/O path.
>>
>> @@ -624,6 +630,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
>>                          size_t size, off_t offset, struct fuse_file_info *fi)
>>   {
>>       FuseExport *exp = fuse_req_userdata(req);
>> +    void *copied;
> Do we have a good way to annotate variables that require qemu_vfree()
> if non-NULL for automatic cleanup?

That would be news to me, but if so, I’ll be happy to use it.  (The 
problem is distinguishing between what needs qemu_vfree(), and what 
needs g_free(), I suppose.)

Hanna

> If so, should this be annotated
> and set to NULL here,...
>
>>       int64_t length;
>>       int ret;
>>   
>> @@ -638,6 +645,14 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
>>           return;
>>       }
>>   
>> +    /*
>> +     * Heed the note on read_from_fuse_export(): If we poll (which any blk_*()
>> +     * I/O function may do), read_from_fuse_export() may be nested, overwriting
>> +     * the request buffer content.  Therefore, we must copy it here.
>> +     */
>> +    copied = blk_blockalign(exp->common.blk, size);
>> +    memcpy(copied, buf, size);
>> +
>>       /**
>>        * Clients will expect short writes at EOF, so we have to limit
>>        * offset+size to the image length.
>> @@ -645,7 +660,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
>>       length = blk_getlength(exp->common.blk);
>>       if (length < 0) {
>>           fuse_reply_err(req, -length);
>> -        return;
>> +        goto free_buffer;
> ...so that this and similar hunks are not needed?
>


