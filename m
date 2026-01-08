Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731B6D185F3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdq4W-00067y-JB; Thu, 08 Jan 2026 08:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdq4U-00067S-Dp
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:29:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdq4S-0003iF-3p
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767878938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fwu8shZQfS/Cp980Em/H9/ahGw3FveQLTeB+rEz/npA=;
 b=Jhts2MWrnxLunVDQrbPz5pS5R8XAJhfCKkY+Bugw4gzzAss1BuyhL+C5E76OpsuXtDqnCT
 qs3X8vU7IIgcAlONvY0Lq0boITLWxr9xHur4npj5UNfZosoZuaQy7sG8AWMHzKp10sz/zz
 KHupMUEEB/ofyx58tjPbTGkJLz9/8w0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-wPEU5vRkPhql3PukbCnEww-1; Thu, 08 Jan 2026 08:28:57 -0500
X-MC-Unique: wPEU5vRkPhql3PukbCnEww-1
X-Mimecast-MFC-AGG-ID: wPEU5vRkPhql3PukbCnEww_1767878936
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4325cc15176so1536457f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767878936; x=1768483736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fwu8shZQfS/Cp980Em/H9/ahGw3FveQLTeB+rEz/npA=;
 b=RhzY6GxyWlp/Zrr1PjGgSrZzG1I8/5SeYrmhgwCgtfRG05MqTLBT5Z5O63ggxRgC4+
 k3uEnwVXKI6+xZFwjdqnB6U71BBCHbkuK3Dds5UkIbNEw8mpZQg43el1OnXg2TFIsBIZ
 ZyMa1VP52EOT86tzhAhSeCLwSUyhVqSb82h1DBO2AHZhDvi3IOW5K7ogmCLYjC8QFcEM
 IOBip6AZX1XomWA0OSEOPmWCWOtiMFsSX7R30IX2YdzWwFW0PLF9K7/UTWdsU6C0MfVz
 tidd7DLk0Tr6ZJnZqGt2yoacJs8dNehEAd2my+UUpP7WSE0JLWx9otpYgugTbXkEKTyl
 wcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767878936; x=1768483736;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fwu8shZQfS/Cp980Em/H9/ahGw3FveQLTeB+rEz/npA=;
 b=Iff7pucwmTWa5z1wI18tcG81cjiDM5TNmkj+GqAMUDfD6b+9B0SqUtJ6u3T2UMfSmU
 851Pbto3wCtB1XPdPG2zz6m78dwxupDF7fEE309yvA3mTq1ttOsogkYKq8JDMbCMMY4N
 rv7vZFFcyAQ4gt+Kr+lG1daAD4kWcy8ZN4qeY2VhKJH5O90EKUDjaAawwo6UEn2Cc2T4
 Pp1ARFc8O+8/6vL4X4dt2c3zZZBww3x/J1xAifqA6itUzMK2wXUYQ5sznDqqoJJ/fW/1
 gTe/C3FRqsUpzFiPj25S9Nd3VnEu01HZJZTvZxdhbqdmdH2t75Ka8gnfbsmPkvxrSbmV
 7K6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqnCZvvGLqUJSnl3hwUH4oeSixs5sLscRhSydxrpmapDjVm27MFmvAklTzITAGtzKkpmrQk/WTkylW@nongnu.org
X-Gm-Message-State: AOJu0YzDn/orWgMw9i9ukmSbBbYp7M6L1KmKCJKSzZIcquY5TaCUK7b5
 mQCCVkGDrzR/lWA8uOveJBUbIfS2Ck/ctPiCrDhOfHDmysCWOEwGMnSZxh29twpDt/60LMlRGo8
 77+XMCvpcpi4oj2TilwnAETihpBUZVjNLs/JtoAGutIhTb4NjKXsF1Glp
X-Gm-Gg: AY/fxX4cdkWKY7qiWSnHhQ67nsfk3pfdiwwpLXcBwYY5T9YpE3NC5elugAyQuUYLhmp
 5g5y35nF2W0xf5bHO2wmfv6ARdIy5St4vqysIX1+lqlGExNYCJFhYqCR+bsanFrlA963Eqx8x+E
 nSYiYFfv8Uivv2mS4X02SKL2gdXlNIY71rkd/X1zjJF9MGLPzdrTDVdBfkfdu/XYbT31j2qmWvz
 ZYixW8G24y05nobHUgcgP3RNqNVfantWNf6Rp6z4g9PSabh7s0X+L2Hqn8b1vmEGhWzUDl6sh61
 jbwwX1a3+xk/BL63D77DxJmLcdV6bDTnKfMvU4oMf70MKe42hKo52sMYcIJIYvhaEwesE/6U6qY
 pr8KpWDS2LOlMqC7IRmpERmktqCo75qc1qwNQBn7PNR+b3Oos9a8S305xXrZvuLQAS6HYWsoNFP
 MpJEZQU2J6ZYznGw==
X-Received: by 2002:a05:6000:40dc:b0:432:5bf9:cf2e with SMTP id
 ffacd0b85a97d-432c377298amr8121727f8f.13.1767878935756; 
 Thu, 08 Jan 2026 05:28:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnOreC053VLCnMGTi1OrjehjrSxMJswSBh70+gqjFZRzwUeAD7WOODwHu0S6VycgT8MC+zeg==
X-Received: by 2002:a05:6000:40dc:b0:432:5bf9:cf2e with SMTP id
 ffacd0b85a97d-432c377298amr8121692f8f.13.1767878935227; 
 Thu, 08 Jan 2026 05:28:55 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16f4sm16928121f8f.11.2026.01.08.05.28.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 05:28:54 -0800 (PST)
Message-ID: <41a78ed4-8dba-4a8e-a33a-7b3dbd1b2af2@redhat.com>
Date: Thu, 8 Jan 2026 14:28:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/i386/tcg: remove register case from
 decode_modrm_address
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260107151400.273916-1-pbonzini@redhat.com>
 <20260107151400.273916-6-pbonzini@redhat.com>
 <9a0b5cc2-fddc-4c9d-a310-4ff4bc785c7c@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <9a0b5cc2-fddc-4c9d-a310-4ff4bc785c7c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/8/26 00:44, Richard Henderson wrote:
> On 1/8/26 02:14, Paolo Bonzini wrote:
>> Unlike the older code in translate.c, mod=11b *is* filtered out earlier
>> by decode_modrm.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   target/i386/tcg/decode-new.c.inc | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/ 
>> decode-new.c.inc
>> index 243df7e3735..7b595607fa7 100644
>> --- a/target/i386/tcg/decode-new.c.inc
>> +++ b/target/i386/tcg/decode-new.c.inc
>> @@ -2024,12 +2024,6 @@ static AddressParts 
>> decode_modrm_address(CPUX86State *env, DisasContext *s,
>>       rm = modrm & 7;
>>       base = rm | REX_B(s);
>> -    if (mod == 3) {
>> -        /* Normally filtered out earlier, but including this path
>> -           simplifies multi-byte nop, as well as bndcl, bndcu, 
>> bndcn.  */
>> -        goto done;
>> -    }
>> -
> 
> I can see that this is true, but one has to dig around to see that it's so.
> 
> There's enough prep code duplicated between decode_modrm and 
> decode_modrm_address that I think it would be worthwhile to merge the 
> two functions and simplify.

Is there really so much?  I guess you could write the combined function like so:

     int modrm = get_modrm(s, env);
     int mod = (s->modrm >> 6) & 3;
     int rm = s->modrm & 7;
     if (mod == 3) {
         op->n = (rm | REX_B(s)) & reg_nb_mask(s, op->unit);
         return;
     }

     int def_seg = R_DS;
     int base = rm | REX_B(s);
     int index = -1;
     int scale = 0;
     targe_long disp = 0;
     bool is_vsib = decode->e.vex_class == 12;
     switch(s->aflag) {
         ...
     }

     op->has_ea = true;
     op->n = -1;
     decode->mem = (AddressParts){ def_seg, base, index, scale, disp };

but it does not seem so much better...  I guess I could do the modrm
split just once:

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 41012659104..23cae451eb7 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2247,21 +2247,19 @@
  
  /* Decompose an address.  */
  static AddressParts decode_modrm_address(CPUX86State *env, DisasContext *s,
-                                         int modrm, bool is_vsib)
+                                         int mod, int rm, bool is_vsib)
  {
-    int def_seg, base, index, scale, mod, rm;
+    int def_seg, base, index, scale;
      target_long disp;
      bool havesib;
  
+    assert(mod == 3);
      def_seg = R_DS;
+    base = rm | REX_B(s);
      index = -1;
      scale = 0;
      disp = 0;
  
-    mod = (modrm >> 6) & 3;
-    rm = modrm & 7;
-    base = rm | REX_B(s);
-
      switch (s->aflag) {
      case MO_64:
      case MO_32:
@@ -2379,16 +2376,18 @@
  static int decode_modrm(DisasContext *s, CPUX86State *env,
                          X86DecodedInsn *decode, X86DecodedOp *op)
  {
-    int modrm = s->modrm;
-    if ((modrm >> 6) == 3) {
-        op->n = (modrm & 7);
+    int modrm = get_modrm(s, env);
+    int mod = (s->modrm >> 6) & 3;
+    int rm = s->modrm & 7;
+    if (mod == 3) {
+        op->n = rm;
          if (op->unit != X86_OP_MMX) {
              op->n |= REX_B(s);
          }
      } else {
          op->has_ea = true;
          op->n = -1;
-        decode->mem = decode_modrm_address(env, s, get_modrm(s, env),
+        decode->mem = decode_modrm_address(env, s, mod, rm,
                                             decode->e.vex_class == 12);
      }
      return modrm;

> 
> Also, not do things like
> 
>          switch (mod) {
> ...
>          default:
>          case 2:
> 
> where the default isn't reachable.

I agree and was curious to when it dated... and it's March 2003 :) (commit 4b74fe1f001, "many fixes", which brought in the very first implementation of 16-bit addressing modes):

+        default:
+        case 7:
+            gen_op_movl_A0_reg[R_EBX]();
+            break;

Paolo


