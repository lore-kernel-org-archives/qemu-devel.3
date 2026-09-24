Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF13C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9fdr-0004be-7N; Thu, 24 Sep 2026 05:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9fdk-0004bL-QP
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9fdj-000297-09
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790241672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BSaxgX1QQ1A6glHUNf5Eoky8ZcwdCI3ONt9HJto076Q=;
 b=YfsGjA/fAZ11zAt6j3JCoT/ekJYYKVp+dlI9WqohX1Ac+ffvHFn0f5gmmPrxyll66XcG/r
 OmiUwYgH8V3M/xF/FAPDZNYU0sGSm9jHMg+8IOfqFVmwB50S016keW6XL1jVTqcfU8Mq4w
 f8iz8t1LIwmxqwAAa5QOoudNlPXTmOs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-EkTW3z89NrSLtGs2n2cwKA-1; Thu, 24 Sep 2026 05:21:11 -0400
X-MC-Unique: EkTW3z89NrSLtGs2n2cwKA-1
X-Mimecast-MFC-AGG-ID: EkTW3z89NrSLtGs2n2cwKA_1790241670
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e735659b7so13829655e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 02:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790241670; x=1790846470; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BSaxgX1QQ1A6glHUNf5Eoky8ZcwdCI3ONt9HJto076Q=;
 b=Naw0NfxgvLfnuhcHP03X6R5E9uS6Y6aJC/VXH28QJKkTofBtqLw54iNLLo9IcorWNJ
 xCjRHxQgw8EHZywdCwL9htTXNCoGT91eFhuhjoAmAhsGA0wAqYwPwB+PNRXEc8O3DYPz
 rbxpEW9rgXRv1pC2jxlLpW07n6X2LOSoXa36LafyhnwXFI5Kaf23tNJLaGSaI0IDVzBf
 8mfq7dstiCSpKqv2llEgrhYX/059r2xlEHMU1Xma0GMYIEyNhX4G0xgdUD8RRggUpBDy
 7StVHyOga1LB3CQgl1mAxK4XU55CG4EtMADz0Pxd7oBP5iytLrCHYO8OoKLGy6hMBEXQ
 Krkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790241670; x=1790846470;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BSaxgX1QQ1A6glHUNf5Eoky8ZcwdCI3ONt9HJto076Q=;
 b=gL9di7M+HS675/4t0OeNC6xbvdxJmDr6Xv1mMdWjN039nZ9rsruOuXemYng2I+mPAj
 tZB7K23nNqGBc9J2YN8fRCv62SQcvqDcoK3GOEfMmZs3kh3HlSQxANg/xuRcLAPjt1jZ
 hTN4ZQbTKcfW5W2yKzVi/8G3gEhGnd73Odw1gXogLmceBqHhwX+JCN+f5j4Yzlmktpcj
 NBD8M9qi43B9bpjR3BAcdrSyz7MefA0onEPysM34vX3hfDHptUjj1SPJH68CPOi6YbwY
 3A0Wk6t8wYPPbOGYL+XOyBqho2Y33hEdgjIIOkgrh2Tg6UgMr1x14N+EVZGfhf0HTeIY
 lfzg==
X-Forwarded-Encrypted: i=1;
 AKwUvByTybPROdxk0gLlRD50f84WAjN7T+f4XaUPqAFifyNFcoctz/YmKaPkQCMvicFIi5mWi9PCEoCFA9Qi@nongnu.org
X-Gm-Message-State: AFuF++nCC+qwuLAK3aSJMdZ345NarQR8seuMKMUDZ4bEc/BCwyVmn0P5
 h71Oy/cC9hpTRhNCJHx75RxysHVgjzzRHzUgXXh3/B8LQ6XAXuMhXLSg6+FkHa/T3zCi1YnrQNa
 l/mDpXnZONh3afufKPLPMQab+09HWCQmulBWJPnCCnEwCKjdJ5OkhxMxx
X-Gm-Gg: AYBFou1JCnxcd96AXHMQ2dggsjFd+me7u0nHyVFvrfXSbGloznpnTpV94wTQz4ji9jz
 pDSgfNZ8fbkYGO6Xs/ygc5bTbZNmXEhjiZkw3XLeSFaV9Gl6Q3DQTTuJ20D9l3GHoYOnZrmwJHq
 BT1KP+R4Cs4ThpRXILdKqKc+GCAoHOQTWKV5bCOJwa1JEzXJ4oVGyGf1BCJ/nRV0wCsKjA1dbI4
 umrdb0Soe41DNxC6FxdSG0Kg0EBvsghEKmvukAZTkrMzMrszVumLhPmetpKRmv3c7wH+wq55T8A
 ED8TjjXFvP0TP3wFVyHGK4vZu8E3YJ9uw3PkrAjU9awD7WcwUwxAJenh0xKhKrMLC0g4+w==
X-Received: by 2002:a05:600c:1546:b0:49e:7a00:b9a5 with SMTP id
 5b1f17b1804b1-49fe66bdee6mr32108975e9.4.1790241669944; 
 Thu, 24 Sep 2026 02:21:09 -0700 (PDT)
X-Received: by 2002:a05:600c:1546:b0:49e:7a00:b9a5 with SMTP id
 5b1f17b1804b1-49fe66bdee6mr32108775e9.4.1790241669611; 
 Thu, 24 Sep 2026 02:21:09 -0700 (PDT)
Received: from [10.22.3.85] ([91.26.127.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdf158147sm105014965e9.0.2026.09.24.02.21.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 02:21:08 -0700 (PDT)
Message-ID: <a024357b-4142-4323-b5ee-b45fd3a36249@redhat.com>
Date: Thu, 24 Sep 2026 11:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/7] hw/usb/hcd-xhci: Limit DMA transfers to plain memory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260924090558.801845-1-thuth@redhat.com>
 <20260924090558.801845-3-thuth@redhat.com>
 <563a8d0b-02a3-49f0-a349-557a4e29fb32@oss.qualcomm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <563a8d0b-02a3-49f0-a349-557a4e29fb32@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/09/2026 11.12, Philippe Mathieu-Daudé wrote:
> On 24/9/26 11:05, Thomas Huth wrote:
>> XHCI is a complex controller, involving lots of descriptors that
>> are written and read via DMA transfers. As some recent bugs like
>> https://gitlab.com/qemu-project/qemu/-/work_items/3926 revealed,
>> this can sometimes be exploited from the guest side to crash or
>> stall QEMU.
>>
>> The code currently does DMA writes with the MEMTXATTRS_UNSPECIFIED
>> attribute, i.e. the controller is allowed to write to other MMIO
>> regions, too. However, in normal operation, this should not be
>> necessary, all descriptors should reside in normal memory. So let's
>> decrease the attack surface a little bit and limit the DMA writes
>> to normal memory here.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Message-ID: <20260915123242.549150-1-thuth@redhat.com>
> 
> I had this tagged to review but low priority since RFC, anyhow LGTM.
Thanks for your plans! ... I already assumed there would be nobody looking 
at this. Anyhow, I think we likely won't find out whether there is any valid 
scenario where the USB controller could write to MMIO space if we don't try 
to include this, thus I added it to this PR to include it rather early than 
late in this development cycle, so it gets enough testing coverage. If it 
breaks anything, we can simply revert it again.

  Thomas


