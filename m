Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DA0C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 11:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fGw-0002W2-D0; Fri, 04 Apr 2025 07:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0fGL-0002L2-Ar
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0fGJ-0007zi-9e
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743766261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LhJAb5wtdcHhrLoyB4Ssy4mbZf3UFDPhBkobmVLZirE=;
 b=cHqCXnYumDVnVnpguq9kWwv8jcLcSvususxk5FciGADpoVaQxfKrx9KVzYWvw1fu6qPQhQ
 RNKsMCajK7Yaq4tDk+wnGKmUZGKI2/4v/g37Dkl+lhMXY2tx7bZ1ipdnlS5MKaOJq2QyQ9
 2yyjxkFG8x+SVKwCitzj22yvN2uzvXU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-RQLc9hjLNpeV7aHpQQvjwg-1; Fri, 04 Apr 2025 07:31:00 -0400
X-MC-Unique: RQLc9hjLNpeV7aHpQQvjwg-1
X-Mimecast-MFC-AGG-ID: RQLc9hjLNpeV7aHpQQvjwg_1743766259
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43bd0586a73so13006085e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 04:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743766259; x=1744371059;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LhJAb5wtdcHhrLoyB4Ssy4mbZf3UFDPhBkobmVLZirE=;
 b=oTzK68hVr2lGRnVoDEixZqUiLh3mzCdqDbhgM1aT6d13bPKLDm71bWqoDtZJgGfkzJ
 R9mxm8hpI9eIuN9r1qoIh4zAWQGfHsStTZw3znBCCi8B3p/BUaX/KCbL+RDte+tfK0dc
 CsHqiJmcwigHdgrAezFBCrh0NXoeHJqY1SQ3SZvniij6ALjv9aZ4Qap6af7sS6Kray/O
 ntZ2ISftbsMU0LykLFq+y6DOWX4bl/spqp4LdARoddXy68BHpKWnUIXKCNpGfGMH3skP
 axGAHcWeWIC7EdKFKG7pp+chJ9jg7qndsOdfIj04ptwxJxelfvcpEaVhuoHKa9zihz0v
 tpiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAZab6a/EN2hVpw3IMg18rRsWP8hV+8scQwLqEqkVgajFFfIcIJJcdkJsZglaY95//8q6W62jaaR2w@nongnu.org
X-Gm-Message-State: AOJu0Yw7NsdmZo87mAxOQBm3YL/ueeao20OObNCF3zgUXHLCAHESlM4Y
 pZwvyjChGNCB8KRzkflk7sbLrp2eOg2FR08/L6sgcpourx+rXErKRSZarSk5BPlSA6DKbSuzbnz
 PDWBj/PdQXEZsSBnX8zmylyVcPTXOFxXM6KR4ArokxNeso3TROnHp
X-Gm-Gg: ASbGnctHWuDe2bSM0jRoDDWKpBPVh30jnNEzDcC0GAKjNLxhzAhrJexVrYRPrr4eFpk
 TZcwqo+VjAuYpnP09Tij7/wuH7Jr1NufHzLJior3EaQHdcpa4/VFpviwCYYYHtS8qo7Zr2fQp8X
 rDLNNWXj1TpjIM+WnBG46ifrVDVN07+i1jZXM4aw/LUM8XO63JFmhG+uItIPwTmXtxWolZ53HWC
 0f4BFXH8+cRlnNZKs68L4tRCXSsKKQOJgE4cJ+4KXJrrul1e4bC+UzIWsQ7TUl7fHDZBWQ4w+uZ
 CP4ZDn1O3D6WjEnG5lgxZpeKuetPEZf302FvYF5G9JXgpfWmYAGckg5cUDOiptXYzW8Lip/svKc
 xXBWHM2KLyDMTGxE4rqlKBT/R7dnM3Upqpgiyzd88Uw1a
X-Received: by 2002:a05:600c:3ba4:b0:43d:1b74:e89a with SMTP id
 5b1f17b1804b1-43ecf89d5b9mr20090975e9.9.1743766259213; 
 Fri, 04 Apr 2025 04:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgVoDo1DCKk65ZSYYocRd1Nd7cdE+MWwQrWvlnJdb+AXM5aCI1jy061nOqQnFzxlbBjvwGNQ==
X-Received: by 2002:a05:600c:3ba4:b0:43d:1b74:e89a with SMTP id
 5b1f17b1804b1-43ecf89d5b9mr20090675e9.9.1743766258689; 
 Fri, 04 Apr 2025 04:30:58 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74f:9d66:d61a:f3cf:3494:9981?
 (p200300cfd74f9d66d61af3cf34949981.dip0.t-ipconnect.de.
 [2003:cf:d74f:9d66:d61a:f3cf:3494:9981])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364d071sm42884295e9.32.2025.04.04.04.30.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 04:30:57 -0700 (PDT)
Message-ID: <eb9fb2a0-6c3f-4abd-a6f8-ac6f0cb643f5@redhat.com>
Date: Fri, 4 Apr 2025 13:30:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] fuse: Manually process requests (without libfuse)
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-10-hreitz@redhat.com>
 <pvipn7y6bo63qthkluaxinsz6cnlp4ld5frdhjcuwla2sknq25@sxvxxkhsx4zv>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <pvipn7y6bo63qthkluaxinsz6cnlp4ld5frdhjcuwla2sknq25@sxvxxkhsx4zv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

On 01.04.25 16:35, Eric Blake wrote:
> On Tue, Mar 25, 2025 at 05:06:51PM +0100, Hanna Czenczek wrote:
>> Manually read requests from the /dev/fuse FD and process them, without
>> using libfuse.  This allows us to safely add parallel request processing
>> in coroutines later, without having to worry about libfuse internals.
>> (Technically, we already have exactly that problem with
>> read_from_fuse_export()/read_from_fuse_fd() nesting.)
>>
>> We will continue to use libfuse for mounting the filesystem; fusermount3
>> is a effectively a helper program of libfuse, so it should know best how
>> to interact with it.  (Doing it manually without libfuse, while doable,
>> is a bit of a pain, and it is not clear to me how stable the "protocol"
>> actually is.)
>>
>> @@ -247,6 +268,14 @@ static int fuse_export_create(BlockExport *blk_exp,
>>   
>>       g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);
>>   
>> +    exp->fuse_fd = fuse_session_fd(exp->fuse_session);
>> +    ret = fcntl(exp->fuse_fd, F_SETFL, O_NONBLOCK);
> fctnl(F_SETFL) should be used in a read-modify-write pattern with
> F_GETFL (otherwise, you are nuking any other flags that might have
> been important).
>
> See also block/file-posix.c:fcntl_setfl.  Maybe we should hoist that
> into a common helper in util/osdep.c?
>
>>   /**
>> - * Handle client reads from the exported image.
>> + * Handle client reads from the exported image.  Allocates *bufptr and reads
>> + * data from the block device into that buffer.
> Worth calling out tht *bufptr must be freed with qemu_vfree...
>
>> + * Returns the buffer (read) size on success, and -errno on error.
>>    */
>> -static void fuse_read(fuse_req_t req, fuse_ino_t inode,
>> -                      size_t size, off_t offset, struct fuse_file_info *fi)
>> +static ssize_t fuse_read(FuseExport *exp, void **bufptr,
>> +                         uint64_t offset, uint32_t size)
> ...
>>   {
>>       buf = qemu_try_blockalign(blk_bs(exp->common.blk), size);
>>       if (!buf) {
>> -        fuse_reply_err(req, ENOMEM);
>> -        return;
>> +        return -ENOMEM;
>>       }
>>   
>>       ret = blk_pread(exp->common.blk, offset, size, buf, 0);
>> -    if (ret >= 0) {
>> -        fuse_reply_buf(req, buf, size);
>> -    } else {
>> -        fuse_reply_err(req, -ret);
>> +    if (ret < 0) {
>> +        qemu_vfree(buf);
>> +        return ret;
> ...since internal cleanup recognizes that plain free() is wrong?
>
>>   #ifdef CONFIG_FUSE_LSEEK
>>   /**
>>    * Let clients inquire allocation status.
>> + * Return the number of bytes written to *out on success, and -errno on error.
>>    */
>> -static void fuse_lseek(fuse_req_t req, fuse_ino_t inode, off_t offset,
>> -                       int whence, struct fuse_file_info *fi)
>> +static ssize_t fuse_lseek(FuseExport *exp, struct fuse_lseek_out *out,
>> +                          uint64_t offset, uint32_t whence)
>>   {
>> -    FuseExport *exp = fuse_req_userdata(req);
>> -
>>       if (whence != SEEK_HOLE && whence != SEEK_DATA) {
>> -        fuse_reply_err(req, EINVAL);
>> -        return;
>> +        return -EINVAL;
> Unrelated to this patch, but any reason why we only SEEK_HOLE/DATA
> (and not, say, SEEK_SET)?  Is it because we aren't really maintaining
> the notion of a current offset?  I guess that works as long as the
> caller is always using pread/pwrite (never bare read/write where
> depending on our internal offset would matter).

Because FUSE doesn’t send SEEK_SET; FDs‘ in-file offsets are maintained 
by the kernel.

Hanna


