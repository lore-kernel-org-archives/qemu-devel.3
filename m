Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625D4CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 12:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vES7v-00061F-Ff; Thu, 30 Oct 2025 08:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vES7s-00060m-Pk
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vES7k-0000hj-0C
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761828683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6806tlwFAjXEWSiTjKyV/vUhY8/XeuGh+ThZLioAQsA=;
 b=WGiWX8MoCBb4fTfMbeFmTgzY+cdtV5Trodl6B0gkPO927hwE5Zj5TlDiINzvaRLWPULd2W
 8MiGVUhqhAl6gvgc38rbc+pI4XF74bXUF474VthgNUE88c/prh1H0F7YrNfQj3FqOSh9kJ
 8Ntqf5sKMIzK1Z5LKK4x0j7TFvaSbGU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-iyIKLiGDMVysbPguSjD7Aw-1; Thu, 30 Oct 2025 08:51:21 -0400
X-MC-Unique: iyIKLiGDMVysbPguSjD7Aw-1
X-Mimecast-MFC-AGG-ID: iyIKLiGDMVysbPguSjD7Aw_1761828680
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-427015f62a7so555749f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 05:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761828680; x=1762433480;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6806tlwFAjXEWSiTjKyV/vUhY8/XeuGh+ThZLioAQsA=;
 b=lpuEAeHNJmWDrwqfTbKAK+hmulQTwaKXGNyjIFS72/aoaubBWh4sbHjE3gsaSf5mFG
 hCxD3YK/AE9KDc5kXhqHcLoy6l8hxioasoge7V81xC2m4ByR2Eun54Zd7J1hmzgbBfU1
 ebERibRuXibBtQ6+TXv0ubs2CXJdFoLhu9Ia5T7coiHte8lVY3Ndr9j6cLLb66bh0KVx
 VQFK4bQwrXey2n3/yc9pQVLmrmIS4o3Y+jpw2UMsjNjczIkFH1vZazwlxrG2T2NwEjSw
 cZFhE37a7xHYScn8ouT5cKilTyM60mpAXVBhxXAFht7YxlA9gVH+0IeuE8evl0Svs5NV
 BQVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWybttP5xF0P6wTfJM+PvpWy0XbNasWYAM4ZSanb+kEGVJPzyAZLMOCWxSAoAUiF9zX17XSjRnz/yRI@nongnu.org
X-Gm-Message-State: AOJu0Yx59hsLbBHdgrWWMf1X23pyNyOrB39k4evtPdTBxCL/IPwRuWsn
 muKxa7lA8jcsSE291Nmrmqj9SFlxxBErF7+BYyvG6IIQrLbmR4DXGjcu0wWuU4crxDz0rqsfjSW
 2D81X7jKvLMqp76QHxlFVNObIkQ3ZPjW+aGW1iysRidJ4wUjGiFwFPdF5
X-Gm-Gg: ASbGncuerjg3ppVEAYwiKduvWnWjZ6MT7RUFU05kPwuSGLUDjKynfOv3iLKwxBhTJmg
 COvTfW86VmFABDmUw+Ok0kF6TVQfFIz8JCVcik2C+tnCGWUrukQqW+Rowa9zSysgb7d5Bixrtzc
 E+Bco8RDhA/AsvvzNl2TzGpWEnfRET/ABqpAWzUT7f066Cxr/D/21uOBZxHw02hbrHlblOR7l1o
 jNWwyzVNY0JmrqF9F1VL8HuVgve3VxFdh8uacAHI1rLRfwdpXdH/LFe/9n9V9y4Rpu+B+qwI+6Y
 LVfe7pGIbfzAxhLajHshGzeIyJ4u5pfIkgKdiut3x6GLOmMvdeEbs7g0JX7ZVx9zwUlvlmU=
X-Received: by 2002:a05:600c:4e08:b0:477:bb0:5e0e with SMTP id
 5b1f17b1804b1-4772686f505mr21861015e9.20.1761828680136; 
 Thu, 30 Oct 2025 05:51:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6qJ82hscVc6LryvgHmzUfuHJBcv7/IhlANupkU7lIPgxezyv6dnRM6k/Xc51VLd9yVxIhjA==
X-Received: by 2002:a05:600c:4e08:b0:477:bb0:5e0e with SMTP id
 5b1f17b1804b1-4772686f505mr21860925e9.20.1761828679672; 
 Thu, 30 Oct 2025 05:51:19 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47728ab375asm39154235e9.17.2025.10.30.05.51.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 05:51:19 -0700 (PDT)
Message-ID: <3fedb6dd-fd2c-48ff-97de-24b4e6d08aec@redhat.com>
Date: Thu, 30 Oct 2025 13:51:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: replace TABs with space
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org
References: <20251007163511.334178-1-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20251007163511.334178-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 07/10/2025 18.35, Thomas Huth wrote:
> From: Yeqi Fu <fufuyqqqqqq@gmail.com>
> 
> Bring the block files in line with the QEMU coding style, with spaces
> for indentation. This patch partially resolves the issue 371.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/371
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> Message-ID: <20230325085224.23842-1-fufuyqqqqqq@gmail.com>
> [thuth: Rebased the patch to the current master branch]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   I came accross this old patch today - it fell through the cracks
>   in 2023, but I think it's still worth to get the coding style
>   finally fixed in these files.

Ping!

Kevin, if you don't have any concerns, could you pick it up via your block 
tree, please?

  Thanks,
   Thomas



> 
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 92987c76fd6..ab40842da9a 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -296,7 +296,7 @@ enum {
>       NBD_CMD_BLOCK_STATUS = 7,
>   };
>   
> -#define NBD_DEFAULT_PORT	10809
> +#define NBD_DEFAULT_PORT 10809
>   
>   /* Maximum size of a single READ/WRITE data buffer */
>   #define NBD_MAX_BUFFER_SIZE (32 * 1024 * 1024)
> diff --git a/block/bochs.c b/block/bochs.c
> index b099fb52fe8..bfda88017d9 100644
> --- a/block/bochs.c
> +++ b/block/bochs.c
> @@ -300,15 +300,15 @@ static void bochs_close(BlockDriverState *bs)
>   }
>   
>   static BlockDriver bdrv_bochs = {
> -    .format_name	= "bochs",
> -    .instance_size	= sizeof(BDRVBochsState),
> -    .bdrv_probe		= bochs_probe,
> -    .bdrv_open		= bochs_open,
> +    .format_name         = "bochs",
> +    .instance_size       = sizeof(BDRVBochsState),
> +    .bdrv_probe          = bochs_probe,
> +    .bdrv_open           = bochs_open,
>       .bdrv_child_perm     = bdrv_default_perms,
>       .bdrv_refresh_limits = bochs_refresh_limits,
> -    .bdrv_co_preadv = bochs_co_preadv,
> -    .bdrv_close		= bochs_close,
> -    .is_format          = true,
> +    .bdrv_co_preadv      = bochs_co_preadv,
> +    .bdrv_close          = bochs_close,
> +    .is_format           = true,
>   };
>   
>   static void bdrv_bochs_init(void)
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 8c738674ced..8be4404c78c 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -133,7 +133,7 @@
>   #define FTYPE_FILE   0
>   #define FTYPE_CD     1
>   
> -#define MAX_BLOCKSIZE	4096
> +#define MAX_BLOCKSIZE 4096
>   
>   /* Posix file locking bytes. Libvirt takes byte 0, we start from higher bytes,
>    * leaving a few more bytes for its future use. */
> @@ -4578,7 +4578,7 @@ static BlockDriver bdrv_host_cdrom = {
>       .protocol_name      = "host_cdrom",
>       .instance_size      = sizeof(BDRVRawState),
>       .bdrv_needs_filename = true,
> -    .bdrv_probe_device	= cdrom_probe_device,
> +    .bdrv_probe_device = cdrom_probe_device,
>       .bdrv_parse_filename = cdrom_parse_filename,
>       .bdrv_open          = cdrom_open,
>       .bdrv_close         = raw_close,
> @@ -4704,7 +4704,7 @@ static BlockDriver bdrv_host_cdrom = {
>       .protocol_name      = "host_cdrom",
>       .instance_size      = sizeof(BDRVRawState),
>       .bdrv_needs_filename = true,
> -    .bdrv_probe_device	= cdrom_probe_device,
> +    .bdrv_probe_device = cdrom_probe_device,
>       .bdrv_parse_filename = cdrom_parse_filename,
>       .bdrv_open          = cdrom_open,
>       .bdrv_close         = raw_close,
> diff --git a/block/file-win32.c b/block/file-win32.c
> index af9aea631cb..16bcef88c68 100644
> --- a/block/file-win32.c
> +++ b/block/file-win32.c
> @@ -741,9 +741,9 @@ static QemuOptsList raw_create_opts = {
>   };
>   
>   BlockDriver bdrv_file = {
> -    .format_name	= "file",
> -    .protocol_name	= "file",
> -    .instance_size	= sizeof(BDRVRawState),
> +    .format_name = "file",
> +    .protocol_name = "file",
> +    .instance_size = sizeof(BDRVRawState),
>       .bdrv_needs_filename = true,
>       .bdrv_parse_filename = raw_parse_filename,
>       .bdrv_open          = raw_open,
> @@ -914,14 +914,14 @@ done:
>   }
>   
>   static BlockDriver bdrv_host_device = {
> -    .format_name	= "host_device",
> -    .protocol_name	= "host_device",
> -    .instance_size	= sizeof(BDRVRawState),
> +    .format_name = "host_device",
> +    .protocol_name = "host_device",
> +    .instance_size = sizeof(BDRVRawState),
>       .bdrv_needs_filename = true,
>       .bdrv_parse_filename = hdev_parse_filename,
> -    .bdrv_probe_device	= hdev_probe_device,
> -    .bdrv_open     	= hdev_open,
> -    .bdrv_close		= raw_close,
> +    .bdrv_probe_device = hdev_probe_device,
> +    .bdrv_open = hdev_open,
> +    .bdrv_close = raw_close,
>       .bdrv_refresh_limits = hdev_refresh_limits,
>   
>       .bdrv_aio_preadv    = raw_aio_preadv,
> diff --git a/block/qcow.c b/block/qcow.c
> index 8a3e7591a92..b442bfe8357 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -1184,11 +1184,11 @@ static const char *const qcow_strong_runtime_opts[] = {
>   };
>   
>   static BlockDriver bdrv_qcow = {
> -    .format_name	= "qcow",
> -    .instance_size	= sizeof(BDRVQcowState),
> -    .bdrv_probe		= qcow_probe,
> -    .bdrv_open		= qcow_open,
> -    .bdrv_close		= qcow_close,
> +    .format_name            = "qcow",
> +    .instance_size          = sizeof(BDRVQcowState),
> +    .bdrv_probe             = qcow_probe,
> +    .bdrv_open              = qcow_open,
> +    .bdrv_close             = qcow_close,
>       .bdrv_child_perm        = bdrv_default_perms,
>       .bdrv_reopen_prepare    = qcow_reopen_prepare,
>       .bdrv_co_create         = qcow_co_create,


