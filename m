Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F0BC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 09:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tetEG-00021P-Sw; Mon, 03 Feb 2025 04:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tetE0-0001z9-9A
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 04:58:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tetDy-0004Tj-OO
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 04:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738576715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CfVR3c8Hz7mgCOGL6MI24KglT+2z6ja28GAcVDx2SaI=;
 b=ejvdxoKZDWVsNHYRpaI6SKQCavkePTkvzRBGb3+oMPOFufkVuu85wsSUpdwiW5ZhOliZWk
 5N4RSY7PiyJ9mCZcc+Ke0hgJmsqqXcKdZrSSxOxyKWwASlP+rbtztykvy+1bV0KiQ3WpIE
 13zTTGXHExphjX50pPO36GTnpEIB9ms=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-g1OR5sKqPSOpUzVJcQHSeg-1; Mon, 03 Feb 2025 04:58:30 -0500
X-MC-Unique: g1OR5sKqPSOpUzVJcQHSeg-1
X-Mimecast-MFC-AGG-ID: g1OR5sKqPSOpUzVJcQHSeg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361efc9dc6so21658905e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 01:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738576709; x=1739181509;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CfVR3c8Hz7mgCOGL6MI24KglT+2z6ja28GAcVDx2SaI=;
 b=SW0QxpQygBKWOWlwBisDTWRMJc2VIpUkkv+1HOzE8qRUUUnkxGFlEVYuOdIofwz5kA
 SDQRVBw2odPOSuARVDsswXyil1pkPTLHTBluNZdcAqld7XTR3uPMSKR6eIz0bPWRMooc
 2uar3I4fG55x/xB0GQgB4lBQa4OXjEi7eh2fgx3LzIvS00HYTz7d5B6vTeWu37z1Eqnv
 J9m6AlA6Wf7T6TquFDrdluuwHaXmg64kdrrZ8VfbDmAgKcsxuqR0utMzEhxJeDlUxEo6
 JdG06cyRmq/8N5YUjY/SsT+dGFERmGiI7Tk/94Jd9vKYzKMWwVkLmrQFYJcRl+U71xx8
 HPTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9ScjcCwL+eCEZbhhwd6ESPFqX3UdOTgXT3Zqr1cb/vLsX7RiAbbhPsjPujnOcy5UC/3jK/atWjHQ7@nongnu.org
X-Gm-Message-State: AOJu0Yz73aw42unu8RsAyOWQb6ZpFQI6nU/BoDIRj7zbIHA++prS37dd
 1iSkq7aAz+ZK61jSFOVwTY6CX9X07DHf5Z9PgVDjklEm7Yqr8fmZWf3yl6SIJbY705kF3D7a8PD
 yIaF0x3LE5bYa3WJlL7OrXGeR9673UnwwN6OqyIwp48XixJRGeDWS
X-Gm-Gg: ASbGncvTWJ0/mCK6F8j/nUz5LisqHdDqooAgyqMaf2t+bIEJYYBZlgUqSX695GEI8u5
 pV7l2v5BRsTx4ly487MqTo0m05sIxQZTCVGeBh4yUN9QBZf2oHK4mI0fgbFzQ2upiwK4k7l+/IB
 QHBey5sLlgxExNdmOiAKSWh/uLMAHawTzWsxzheb+fEmTf/R8pwkHuHVq9ZjEW4CC1JyaA9sssc
 34iLwP3yBTfQxUT5OEhIajdyDaaHE/IoLE3Vs9rED1Jbzc0bOEetI4N3lohuxOxK9GxL4Bwffcd
 gESZgPECZDEGbqlF7rNv7S6blOyMZw==
X-Received: by 2002:a05:600c:1f10:b0:434:f8e5:1bb with SMTP id
 5b1f17b1804b1-438dc3af90cmr184491475e9.12.1738576709615; 
 Mon, 03 Feb 2025 01:58:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEujqhfa1qIf3iTt0h6DJDQVAu2cKXExqQ4ucZQTChEyy7TRnMv92KMOR2D5KUKgr+7zdT8fg==
X-Received: by 2002:a05:600c:1f10:b0:434:f8e5:1bb with SMTP id
 5b1f17b1804b1-438dc3af90cmr184491215e9.12.1738576709269; 
 Mon, 03 Feb 2025 01:58:29 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6de2dsm185485985e9.26.2025.02.03.01.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 01:58:28 -0800 (PST)
Message-ID: <49d601e0-9a35-4c70-ace7-415dc6175a9a@redhat.com>
Date: Mon, 3 Feb 2025 10:58:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] meson: Drop tcg as a module
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, "Jose R. Ziviani" <jziviani@suse.de>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250203031821.741477-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On 03/02/2025 04.18, Richard Henderson wrote:
> The fact that this is only enabled for x86 probably means it
> was done incorrectly.  Certainly the set of files selected to
> go into the module is woefully incomplete.  Drop it for now.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/meson.build | 11 ++++-------
>   meson.build           | 18 +-----------------
>   2 files changed, 5 insertions(+), 24 deletions(-)

Looking at the cover letter 
https://lore.kernel.org/qemu-devel/20210624103836.2382472-1-kraxel@redhat.com/ 
it indeed only mentions "a small fraction of tcg (x86 only)", and since 
there were no follow up patches, it sounds like an incomplete conversion to 
me. So reverting it three and a half years later sounds reasonable.

Reviewed-by: Thomas Huth <thuth@redhat.com>


