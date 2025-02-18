Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90552C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 08:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkJLr-0008BG-Te; Tue, 18 Feb 2025 03:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkJLq-0008B3-VI
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:53:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkJLo-0004Tm-JM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739868786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iIA9otTJD1FRqfT0P+Uav97EfYwiOXUG7z+vKOYnjSg=;
 b=E/Boa+EqIeTa0PyuRlOamPcZef2QvXMyr339r+gx8k4dpr/2kFo0b4FEW/A95myk7nA0zJ
 xyi5+Ym3AWTQg1KGgPTkBPO2ok16SLs3LU67THH5PLRdcLkKgR6TOMSUOsw0I4DDCSED7J
 GD0ImTPKLnsv/fxWxlB2l/LZ7835ufU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-PZ7DeohIM-SrOdJC_11FKA-1; Tue, 18 Feb 2025 03:53:03 -0500
X-MC-Unique: PZ7DeohIM-SrOdJC_11FKA-1
X-Mimecast-MFC-AGG-ID: PZ7DeohIM-SrOdJC_11FKA_1739868783
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f42f21f54so954153f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 00:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739868782; x=1740473582;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iIA9otTJD1FRqfT0P+Uav97EfYwiOXUG7z+vKOYnjSg=;
 b=iiXS1Uuj9vtx7oVD5/qCzYmjDdsRBqzRuMHBFZER1CfqqOYoTXTFiDx3YCQFIDEpwn
 ljKTiOMR5135K1lYOFVDUJ1hl1uXrrP083gYpFMzBpBrkbFh7Cs1XFWCC0D2JSWIEYVc
 adWAfo+bZEFlW1AjJwZltj2y0HG4iURUJfXlJmTp5IBBuhM1agUaHq8f172Udk/EOaW4
 v/McgNkvnte9VEo+cvoyHLQh/c/8kfEh8CulJ0XLo/3+DhksVusfandht7kQ6mD/49G/
 LfwgZKrJCwtDZ+RJ63T2ByM2t/hzMSVnc7VAIVe6atXKD34Eqt23mhUpDTTmx84E/5tp
 B19A==
X-Gm-Message-State: AOJu0YwgHTz87bklNMIEy/5iOrvpJlNxJSzAZN2JPFHfAF74/TWYqME5
 MGxHlawNe7FJJ9cacSjQlLUkXqlKBUJMv0n3hfSxoSwKwgOsBP8ifA0Dt8aIvZdyxG02IhnWpDF
 wjyOVFUlMyIeGYbX5pga7CqfCHyaxRXtfDbUZxvI/LK4xV7FGSEcEOtDGFSy2mSg=
X-Gm-Gg: ASbGncv76eouuBaoZC8k8p8SmYfOZVJa2uwoIokN3+tGjMmQqdxup0yM45qRtkgBV/k
 CnNZpFXRZib8hvDj4lVf35L8WGEP64Kqt9ALhHTtti57+8bwNE4rwJidvhcz5MIasS43X5nKfVE
 itffjtLfRWPnhGXJv0gxfNhKNoEXnhR2LaH+sG4s+LZPs0umWE/jA42QqXiOZTIRTqTs5NDR2WB
 pHL6Ik+kkCjj6q/ZXrmVjpdKjJiWcNXqULTAG9bHxLdxmG9DLmeGe2+geVA2OP+xYK0cCcKHps6
 Tsli8bqI7yg=
X-Received: by 2002:a05:6000:1aca:b0:38f:37f3:5ca9 with SMTP id
 ffacd0b85a97d-38f37f36159mr10133213f8f.50.1739868782292; 
 Tue, 18 Feb 2025 00:53:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaeXCaOKlCQdGOcMT7mpHOgtG1G0IpKtlwucq6dGJUF8mfqguWv88IKVlQ0dfHgzlya9rF2g==
X-Received: by 2002:a05:6000:1aca:b0:38f:37f3:5ca9 with SMTP id
 ffacd0b85a97d-38f37f36159mr10133186f8f.50.1739868781864; 
 Tue, 18 Feb 2025 00:53:01 -0800 (PST)
Received: from [192.168.10.81] ([176.206.122.109])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4399558f8d1sm8554185e9.19.2025.02.18.00.53.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 00:53:01 -0800 (PST)
Message-ID: <53739259-69a5-4d7e-9178-f09e1d6ede89@redhat.com>
Date: Tue, 18 Feb 2025 09:53:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/timer/hpet: Detect invalid access to TN registers
To: Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250218073702.3299300-1-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250218073702.3299300-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/18/25 08:37, Zhao Liu wrote:
> "addr & 0x18" ignores invalid address, so that the trace in default
> branch (trace_hpet_ram_{read|write}_invalid()) doesn't work.
> 
> Mask addr by "0x1f & ~4", in which 0x1f means to get the complete TN
> registers access and ~4 means to keep any invalid address offset.

I think this is less readable.

The reason to use !4 in the Rust code is because the initial AND is done
in a separate function, timer_and_addr().  In C you don't have the same
thing.  If anything you could do something like this:

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index ccb97b68066..7c011204971 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -425,6 +425,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
      int shift = (addr & 4) * 8;
      uint64_t cur_tick;
  
+    addr &= ~4;
      trace_hpet_ram_read(addr);
  
      /*address range of all TN regs*/
@@ -437,7 +438,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
              return 0;
          }
  
-        switch (addr & 0x18) {
+        switch (addr & 0x1f) {
          case HPET_TN_CFG: // including interrupt capabilities
              return timer->config >> shift;
          case HPET_TN_CMP: // comparator register
@@ -449,7 +450,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
              break;
          }
      } else {
-        switch (addr & ~4) {
+        switch (addr) {
          case HPET_ID: // including HPET_PERIOD
              return s->capability >> shift;
          case HPET_CFG:

and the same in the write function, but that's also different from the Rust
code.

Paolo

> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   * Note: This patch applies the changes from Rust HPET [*] to C HPET to
>     ensure logic consistency.
>     [*]: The original comment should use "(0x1f & ~4)":
>          https://lore.kernel.org/qemu-devel/Z6edKxYFzA6suDlj@intel.com/
> ---
>   hw/timer/hpet.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index dcff18a9871d..0f786047e54f 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -455,7 +455,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
>               return 0;
>           }
>   
> -        switch (addr & 0x18) {
> +        switch (addr & (0x1f & ~4)) {
>           case HPET_TN_CFG: // including interrupt capabilities
>               return timer->config >> shift;
>           case HPET_TN_CMP: // comparator register
> @@ -511,7 +511,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>               trace_hpet_timer_id_out_of_range(timer_id);
>               return;
>           }
> -        switch (addr & 0x18) {
> +
> +        switch (addr & (0x1f & ~4)) {
>           case HPET_TN_CFG:
>               trace_hpet_ram_write_tn_cfg(addr & 4);
>               old_val = timer->config;


