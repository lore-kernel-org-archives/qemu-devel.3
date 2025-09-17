Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E176DCAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 09:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyoFR-0004BY-Kt; Wed, 17 Sep 2025 05:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uyoFK-0004AX-0f
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 05:14:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uyoFI-0002P4-7N
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 05:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758100474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZrV3wSJFLsh+0/8ERTRnMqxczJeijdh7Sto693JBM3g=;
 b=I3H1/ELStZtxvqgwuRvw5P30/iPIJKvXYpMNzATuKO3wnKXg1SVtqddEqf31uaITmyNgng
 o4NN7dA3FTTbxY6k9spHWazQNcnnD5OpRyUm/mepsbG679oiM046aK6+DG6ArXCwaLEaqv
 fINS+lUc4Qx2fREKULSWo9M0NrziCl8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-3dAuxPbKMn-pkjJduALK0g-1; Wed, 17 Sep 2025 05:14:32 -0400
X-MC-Unique: 3dAuxPbKMn-pkjJduALK0g-1
X-Mimecast-MFC-AGG-ID: 3dAuxPbKMn-pkjJduALK0g_1758100471
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45f2b9b958aso23958195e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 02:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758100471; x=1758705271;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZrV3wSJFLsh+0/8ERTRnMqxczJeijdh7Sto693JBM3g=;
 b=awiLMsP4St532axQ1taFLBoNHCxmfYguykyoD1EXHNU2cQPJBkCW25H8zsPWxUmjvJ
 QjaQ9vWto6EeSM+lWLl0yiJMfhgxvskXPDHI2otxrsJebTMhuzLA6B1ekNCSNPeCwnQi
 drxydH6sa3wjKdyJe2fkBrgAY+04Dn1MzSFi9PyHhYSgEmOQ6ShXKVS8+NoVd6xzGEb7
 BezEi51xWXVM1zrVZKHyqI/00eaSJpk+sViAc0T6QoFW7tdgmuuKleckHhqjIbyo7ny6
 8ebPbPoKa3w/ZrH+gbQzt5jUoO94WtNE1ckCVyshAvGuSgXg1ZuoxDCJCwW1fHCEzU77
 6T6Q==
X-Gm-Message-State: AOJu0YyMAAo644Vrs2+/hHHxLgxgFIS/X304f4b1Y0ecae/egmP57VZ/
 JWKfk2bo0myzyZsqBhGJYAnEfeSMuIeGFPHUFzeJiw2pz5TBLM+JeIcRvz3RTgC0/ub0XSlG+g+
 CXh4nQ4vixsN9UJaurhvSrCvcScC3G5G7GpLED10NSlgYihv0oJxQKacg
X-Gm-Gg: ASbGncspofcyoO9vgoQnzUXh8eJbLChl8ZeSk1daQdO6twd/YhdP+LgnJ6k1Z1wee9F
 +o4i3PYjh9QR5XqHZ7E9q7099rEireuA9jHHynaJQy3PnWWFiKGA1SceRiRgzMlwEBlDfJxB3vs
 lHkeJiYnLPL8JvbbAfD1/SnBOM4SvPkXDXjfvCMs5XitfDbnS/iADhSaAAiDME2FmqYZDwVRk1l
 E2TI26a5PTUPH9ShI8Gk9nn92R5+qtih7Hi+Rng+D9gp8/MtuOBWLArkv1sVKv6/pvdb+5/WgVf
 fEH4JdDpn5CSD+76y+Ih7UrYTjb6asW0pUbmYD/bnTthZ7GWyDLM+1HA/E5GcCnImU/0K2CZ5B5
 zohFROnt0VrolPH3nQMpDqqSW9LtkZcWlm8UTJYKSilo=
X-Received: by 2002:a05:600c:138f:b0:45b:9291:320d with SMTP id
 5b1f17b1804b1-462074c5377mr12405395e9.31.1758100471259; 
 Wed, 17 Sep 2025 02:14:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEmxgu92EHP20rPVmzfYTufMiNW7NMmNylEmR/yhYY3ewoC23dJ0cEaag0bo2PWF1PTFKjzg==
X-Received: by 2002:a05:600c:138f:b0:45b:9291:320d with SMTP id
 5b1f17b1804b1-462074c5377mr12405135e9.31.1758100470760; 
 Wed, 17 Sep 2025 02:14:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45f3260a1ddsm35852495e9.5.2025.09.17.02.14.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 02:14:30 -0700 (PDT)
Message-ID: <637d028b-2bbb-405c-804b-eb921b344b3a@redhat.com>
Date: Wed, 17 Sep 2025 11:14:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 09/12] rust/qdev: Support bit property in #property macro
To: Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
 <20250916085557.2008344-10-zhao1.liu@intel.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250916085557.2008344-10-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/16/25 10:55, Zhao Liu wrote:
> Add BIT_INFO to QDevProp trait, so that bit related property info could
> be bound to u32 & u64.
> 
> Then add "bit=*" field in #property attributes macro to allow device to
> configure bit property.
> 
> In addtion, convert the #property field parsing from `if-else` pattern
> to `match` pattern, to help readability. And note, the `bitnr` member of
> `Property` struct is generated by manual TokenStream construction,
> instead of conditional repetition (like #(bitnr: #bitnr,)?) since
> `quote` doesn't support this.

We're almost certainly going to have more attribute parsing for 
ToMigrationState, therefore IMO it's time to drop the handwritten parser 
in favor of 
https://lore.kernel.org/qemu-devel/20250717062727.305466-1-pbonzini@redhat.com/. 
   Then the extra parsing would be just one line:

+        parser.once("bitnr", with::eq(set::parse(&mut self.bitnr)));

No other complaint!

Paolo


