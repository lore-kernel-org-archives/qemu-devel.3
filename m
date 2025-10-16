Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDD9CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MnR-0008U7-KV; Thu, 16 Oct 2025 08:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9Mn8-0008P7-Tl
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9Mmp-0006uO-AO
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760616515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iM4XvFFYBNbJb/keL2KcZrZrUJ0tw/B9Yex8OvOuNbE=;
 b=QPbYVMmdRVK1YjUzBSryaxwgq9e6ZMIp86AxdGvJL4PtUjWxksUgguDSLAQxEug64JGf52
 AU3QkuwFWLJinKYnhNVNS+2o0QgogwzPR+Hsq9yXTbMDXG+b7K74eidMJ4xXexvAAak768
 CiVs5Pkvfp8xzCKk2mqGHtAr/4F6Lf8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-pceidne2P5OyX1lmTMmLgw-1; Thu, 16 Oct 2025 08:08:34 -0400
X-MC-Unique: pceidne2P5OyX1lmTMmLgw-1
X-Mimecast-MFC-AGG-ID: pceidne2P5OyX1lmTMmLgw_1760616513
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ee10a24246so418755f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616513; x=1761221313;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iM4XvFFYBNbJb/keL2KcZrZrUJ0tw/B9Yex8OvOuNbE=;
 b=TDqciR1jU5eM4y9zxxHe8ErxD+CkAIqFKWNLn9qdX2NIfPDiD5NPy832XYgN1vbmkY
 jIZBYyVIWBmwCXTpC1VjqOlcqPc+CsFGvxlg1PBxvx25Y5rXVqBQ0BruypNiWw4n85u7
 aIF3U6sLHi8B3qdMHqcnxxppFA5j1DPSbro4BNjgCSJhoiUB2LYoxob/G36eQQfOY69w
 aoltQMz76ymPK65+LBuIeKnCBIXP0zfmiTsOaA137a6YLYQZ08WWvtdaAL/qR/h91q9F
 C5dTRsABehx47eeJ3A4BLmiO4Ynj270C5lVb4H8FEQOSTUSDspKNBKgrktcCa8vkZdD9
 94Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUErqygLAmjzh5JUIxpBDFDJ7pV82HDDUtbk+JiVbjj8lowVfRJcO/kh8JnC166BoPnDCa2BtiZxtow@nongnu.org
X-Gm-Message-State: AOJu0Ywzt8L5mubF/ivPC3nYI+/y1I40kHZjoWq7u6UeVUp2EMF/Qonb
 4IUjrFxEdqxo3RrnzkB/LG6ZJzxlCjOMepvJxx+JgoEtNMNEVqshy2SMWSnaAROBuvpksSposbE
 hKWDR+RIJj8X33TX+YMgPH4Xx6Zuddrd/DaqDbWIkTBIV1v1NQiblulL0
X-Gm-Gg: ASbGncsIH5HyZ66CzyNIGD7Zo9o2WU/sJzAuSVne84TVB07JrBwe2kwQyHUnps0Bc6g
 dElnIP153BVWRHdDtAGHnDPh0FiwydwNqnUjpW4qJG0x7Icjckh2tb+KEwNfVS6QBo0kkOo07TS
 Jt4iYT9bTxQsjSQYobn5UqDBsFWQfYe0sMTyHDqPt5ErZIUrnhbLjs/rnQpnkEkW0D99KSXJuS4
 EgutTlsV8DMyZcqjBUtSyKb3TnSo/g+X1tHelzhQVpoTZJMZVWRtKGF58Sg1tYhHTgp1jFnckAj
 pWAyt218ervVkIGyaOUdoS2mUXm7EXZN6IUwtn5/nyUur14jwMQXGhZShWuKotiFZJ1BSflBZM3
 uY02uBhMm8mjyZzJlXHI/uy6HCYJzqoVvZYDY2eH7
X-Received: by 2002:a5d:64e7:0:b0:425:769d:4426 with SMTP id
 ffacd0b85a97d-4266e7dfff1mr19245731f8f.34.1760616512954; 
 Thu, 16 Oct 2025 05:08:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt7QKfTCAOiJL7w77peFXepGU5He9bUsMFqTRH046dIo159g04GHRVH4q6DMrnCKXLLgt1Sw==
X-Received: by 2002:a5d:64e7:0:b0:425:769d:4426 with SMTP id
 ffacd0b85a97d-4266e7dfff1mr19245713f8f.34.1760616512524; 
 Thu, 16 Oct 2025 05:08:32 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e0efasm34280014f8f.41.2025.10.16.05.08.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 05:08:32 -0700 (PDT)
Message-ID: <03c1d056-7319-438b-a2dc-27687108b678@redhat.com>
Date: Thu, 16 Oct 2025 14:08:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/multiarch/linux/linux-test: Don't try to test
 atime update
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20251010121435.3885228-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251010121435.3885228-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/10/2025 14.14, Peter Maydell wrote:
> The linux-test test includes an attempt to check the utime and stat
> syscalls by setting the atime and mtime of a file to specific values,
> and then calling stat() to check that the values read back correctly.
> 
> Unfortunately this is flaky, as it will fail if some other process
> (for instance a virus scanner, backup program, etc) gets in and reads
> the file between the utime() and stat() call, resulting in a host
> syscall sequence like this:
> 
> utimensat(AT_FDCWD, "file2",
>    [{tv_sec=1001, tv_nsec=0} /* 1970-01-01T01:16:41+0100 */,
>     {tv_sec=1000, tv_nsec=0} /* 1970-01-01T01:16:40+0100 */], 0) = 0
> # successfully set atime to 1001 and mtime to 1000
> statx(AT_FDCWD, "file2", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT,
>    STATX_BASIC_STATS,
>    {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID,
>     stx_blksize=4096, stx_attributes=0, stx_nlink=1, stx_uid=32808,
>     stx_gid=32808, stx_mode=S_IFREG|0600, stx_ino=21659016,
>     stx_size=100, stx_blocks=8,
>     stx_attributes_mask=STATX_ATTR_COMPRESSED|STATX_ATTR_IMMUTABLE|
>           STATX_ATTR_APPEND|STATX_ATTR_NODUMP|STATX_ATTR_ENCRYPTED|
>           STATX_ATTR_AUTOMOUNT|STATX_ATTR_MOUNT_ROOT|STATX_ATTR_VERITY|
>           STATX_ATTR_DAX,
>     stx_atime={tv_sec=1760091862, tv_nsec=63509009} /* 2025-10-10T11:24:22.063509009+0100 */,
>     stx_ctime={tv_sec=1760091862, tv_nsec=63509009} /* 2025-10-10T11:24:22.063509009+0100 */,
>     stx_mtime={tv_sec=1000, tv_nsec=0} /* 1970-01-01T01:16:40+0100 */,
>     stx_rdev_major=0, stx_rdev_minor=0, stx_dev_major=252,
>     stx_dev_minor=0, stx_mnt_id=0x1f}) = 0
> # but when we statx the file, we get back an mtime of 1000
> # but an atime corresponding to when the other process read it
> 
> and which will cause the test program to fail with the error
> message "stat time".
> 
> In theory we could defend against this by e.g.  operating on files in
> a dummy loopback mount filesystem which we mounted as 'noatime', but
> this isn't worth the hassle.  Just drop the check on atime.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The failure happens to me occasionally on my local system.
> ---
>   tests/tcg/multiarch/linux/linux-test.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarch/linux/linux-test.c
> index 64f57cb287e..bf6e0fda262 100644
> --- a/tests/tcg/multiarch/linux/linux-test.c
> +++ b/tests/tcg/multiarch/linux/linux-test.c
> @@ -155,9 +155,14 @@ static void test_file(void)

Maybe drop the "tbuf.actime = 1001;" earlier in this file, too?

>           error("stat mode");
>       if ((st.st_mode & 0777) != 0600)
>           error("stat mode2");
> -    if (st.st_atime != 1001 ||
> -        st.st_mtime != 1000)
> +    /*
> +     * Only check mtime, not atime: other processes such as
> +     * virus scanners might race with this test program and get
> +     * in and update the atime, causing random failures.

I actually saw similar problems when looking at the atimes of the files in 
the functional test cache, so I agree, checking atime cannot work reliably.

Reviewed-by: Thomas Huth <thuth@redhat.com>


> +     */
> +    if (st.st_mtime != 1000) {
>           error("stat time");
> +    }



