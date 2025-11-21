Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070AECFA76E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMOUa-0003EQ-No; Fri, 21 Nov 2025 05:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vMOKR-0008IE-AJ
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:25:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vMOKH-0001Ki-I4
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763720697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mP619Xf7apXUow5hCSU/SjZJPjChsAnhjp5c/9UFgus=;
 b=MbXVo00t/sNdYFlquMvnQSvg0tUB4hPvcBGwKUyhR2YKOs9hVteQiYuyICSW3MLUExUGFL
 Copap9G5DQd8hPulESkbHohIBA4xvZwXgVFS+5Umj+cSfT1p4Z89oLcw83k32gkUIRhPjH
 QvlBC5aIdq+3zRegvtrPYjXqpWtAGCs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-_825Ho3DPbi00YAsWh9dTQ-1; Fri, 21 Nov 2025 05:24:55 -0500
X-MC-Unique: _825Ho3DPbi00YAsWh9dTQ-1
X-Mimecast-MFC-AGG-ID: _825Ho3DPbi00YAsWh9dTQ_1763720695
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429c95fdba8so922718f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 02:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763720694; x=1764325494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mP619Xf7apXUow5hCSU/SjZJPjChsAnhjp5c/9UFgus=;
 b=CKTggLpMqgAG4YhFXAxRD7Vlk7h86OpKBi17dk5ykLVsa3zpiwkLA6Q9Ix7Dedl1p1
 dCrVIh+fM9BfKu+D8ZipJbCl+sgY829JW+dTg+eAjC+8o9Vx0TF96xwcfFTfk+gO0SKH
 M2LRzzie/d68eyrB484GX2zhS4DFkjtXAJOdi5loANTVu937taS3NOCrcIBnyML+lH/V
 vf/j1sqmAlR4SzUvnZPd4zmCGN3YOEHLxEmZkxjkAlnsnI4Ft7vt7Owk8Qoa3jPpvvFT
 kSkU9vpsNSTtyAxklIwcDKCVmmNcic3i1DyPNuC2kK5uTQnccvWij8anF04MGbQR8Nl6
 s9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763720694; x=1764325494;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mP619Xf7apXUow5hCSU/SjZJPjChsAnhjp5c/9UFgus=;
 b=OdeDDOwWO/SpauEFN5LeOz/9HVxaFi1W6CB7tk5yKbiaEDL0Ubl4vl9TA3bnx17KpG
 bXaUKn5z4NFiBHwZ+SsxEoZuI8w3no44QWvElAL6IUIMrJ0v0zBSgCpne/Fz3cVI/+9W
 wl8uDWiuscxxF5bmx2QcOEUpq2YIP/BR5Rcj8Dg3COPaYMExxiefpKMbdNay/ZrTRxJY
 QrRFjsshP+oRyvkHdMP2/OfAnl15Pj6A4Muc+ko/UbRw06mvvcoxLNZM2lA8Uvse2w6J
 BdszM5DpvVgu6D9kNuKew0bMbM0VztZ4V6AK0A948vzzHZJqewK89VPUZItLiYHqA4mG
 u/Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXirEKkfOfxo7HBWPr5uZzPVgXTAggD+6otXZg+bl+gb/zSabedeJwlvMiH9Ex1cKU4hLdOaVNVKKPl@nongnu.org
X-Gm-Message-State: AOJu0YzcXzbBoJjSZvEcVjdXLzvIYv+Lfx3flzEbxakoevc2Jjnz276E
 i51xyiIucFvng5biUPVN7olhnGXrsC3UkkGIml28H6hPYvN30Iofs47jGgkJjr3kiX8KwX+7yDy
 U7HVhiHuK52ZtKtyX/DdbftdQ2TD0byFPsCd7I1TGljxgqBIbGNG0udQl
X-Gm-Gg: ASbGncuclcO3oFrm7rBDoWprZQMjawWtQZzbZTRf5tS8srbKIhy/YGo77fvjQ2Od7wb
 KsLC/jKYcVNeDwoxG/o84mVPdN+HpqPE5mhEH8qPWnK87vjGWx/61OTORgpFFdhNduD6tIPHGG/
 SiOgDhfjxGokeCMFJAKSLrBJFYXurbtS7tI31DGdLbbnplRc9DOmHUOeSeNXURQOg9+VLnch8Z0
 NRw6xMNqBMIrt52Q72Eq2o5yEApMMb6t9Ynfuf8XE8hPLle9YIwr2TJGw4i2u07w+DJmXnWhqVG
 sCME5DKwaZs8nlclP5gMMph531HM7ark8WCKogcC8XyG6Be9SQOHtlvC2Iqf1NnKeK2raJUC2uO
 b4Dc3HNZ9WTWX6hgHxLbcOcNT6BKXr6JdY/yLLY5+CACLEAnoIx4gr8FgH5BsJtn2Tys288UWc4
 u3XhipCBDKfFXl5Jk=
X-Received: by 2002:a5d:5c89:0:b0:42b:32f5:ad43 with SMTP id
 ffacd0b85a97d-42cc1ceead7mr1783045f8f.17.1763720694596; 
 Fri, 21 Nov 2025 02:24:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6iZXimUDPd4eFb7Kmiljiz4pjNYuGrlD2iMNepoUfevPehlVidzIIv58J0wTgrmr3aXhLZg==
X-Received: by 2002:a5d:5c89:0:b0:42b:32f5:ad43 with SMTP id
 ffacd0b85a97d-42cc1ceead7mr1783020f8f.17.1763720694212; 
 Fri, 21 Nov 2025 02:24:54 -0800 (PST)
Received: from [192.168.10.81] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8c47sm10735860f8f.38.2025.11.21.02.24.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Nov 2025 02:24:53 -0800 (PST)
Message-ID: <df22536e-c813-4b9a-a9fa-75b9fdc0fb4a@redhat.com>
Date: Fri, 21 Nov 2025 11:24:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/22] mtest2make: cleanup mtest-suites variables
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-14-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251117185131.953681-14-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/17/25 19:51, John Snow wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Remove the "--suite" argument from the .*.mtest-suites variables, and
> add it only when actually computing the arguments to "meson test".
> This makes it possible to look at the set of suites to set ninja-cmd-goals,
> instead of doing it via many different .ninja-goals.* variables.
> 
> As a bonus, this removes code duplication between emit_suite_deps
> and its caller emit_suite.  Since emit_suite_deps would now be one or
> two lines of code, integrate it into emit_suite directly.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>

This and the other two patches are now in master.

Paolo


