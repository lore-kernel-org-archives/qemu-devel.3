Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608C1C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuxAK-0007Gu-0i; Wed, 19 Mar 2025 13:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuxAC-0007DF-9C
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:25:08 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuxA7-0007P7-SY
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:25:07 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso6699654a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742405102; x=1743009902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Ok2Fm7bdcE+cJWt+ydrAGn9kmLZ1Wi88p28g2XuriM=;
 b=umj27/DrxG1VeVAjJjAf7IPedSNFLHogV3jE2GIbd1Je45t5ZFHHGmelGiYOzvRpSF
 pe5F54fq1pd4OOd6mJlrZyN9KgCc9J302WLENbwnkNHDB1AT2U7iUMEKKDUt+VfMc3W7
 fr61k1aUFSbhesOii75+Os6zjlQsvGU+faiXvTQP7rcLQ6Bg8F6AOAxio98iEr77JAPf
 hX+7Fkcxc5IhrouZOC7rUtDhOorZKtkVni+A0NmDnaSQTcGrtzsMrNoB+i66cRgndlEJ
 iC+M/Xz50ANbbCJXDclCiUKXNltQEGJACJjSWc7520Lj/41Rjcp2baGkjclG/eTJS174
 u5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742405102; x=1743009902;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Ok2Fm7bdcE+cJWt+ydrAGn9kmLZ1Wi88p28g2XuriM=;
 b=Op0k68cIHD5OAOfTlIH7s/XV0Vqvfr037EMzv1h36DKfOc7MdR9xsOcyPQoc8zrsCk
 G78EHV64vQd3xpnvu6LRM10ImPuvUnStmcTmdzO6GBCY8ey6RbPT1vIlmlIQXBfWJMi7
 CxKNaJ62F4hqTVD/4ocWFu7fcqD0uk63SPS/Lg64qq8flwbEzW97vg1IRcS/L0p5k/qN
 jPDV/VgmSyWWYlT4tibyri/ZX49m7DdWlUCSHY1ntOch4q2wqE5BXk8vGWBx99pBP8JQ
 +mASaBZIfPDlRBDLfzBIg56BbUanmDph9W0R/cFW9GzkcUGEYCZOS1iA+K1gQ8SF4XN3
 9vsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVumvCtGNlMZckoTGNxsF4ucbz5gt8/I8ixVYZAnBSo+AEl+fIgfL92zjfASGZ+ct+dzRFZ4lHsrkVy@nongnu.org
X-Gm-Message-State: AOJu0Yx5xiBB9q80BxlBIZDYudRkMPq+MMm1FiJ5oQUOCXDzbd3mx5fG
 w6YQUJl0cZSH+BZ+xclUlUfP8BkL1dwiaHZa1BQ3Kx3fpgm2DX8Sh73PuDKjujmVxRA+/0Xnldb
 z
X-Gm-Gg: ASbGncuyJHF/p4X+8IxhVAziczYsh1db8KxhYY0fFlN00G7TzmtVMWaV3e7BRRtygc4
 iFhgIYWvbmLIfolB2JIff0Pfpe8tLm6kH7gfOCZMqimO0eusR0l4M2A2PhSJG2+5Vy5TRfi5ZdE
 LzGKE7m4YhtQZGf5drwDRtgLDkbeb1ieUWGi+4JXoVeJxYvCBrh09ZHe8g4J+y7Sxe+DruCeASc
 vf+LZq1FBpm4fzAGR0N06qjutHJGMu0/EguI+191NQg66+VyepjpPtvXoJfWiKl99Fj91I0A1Z2
 usVSNTtirlR9zOyqOyY7kKM5UEcgtgdH71KlHjHznh7+wctzR8EdREO3dQ==
X-Google-Smtp-Source: AGHT+IHIRqXc0lYnDp9iTP0PnLiDmFULMMoOAIy2ARE4hHeIJVIZFxtV1BreY58fsUuLiJZQBymvEw==
X-Received: by 2002:a17:90a:d60b:b0:2ee:c291:765a with SMTP id
 98e67ed59e1d1-301d50b0992mr135961a91.8.1742405101740; 
 Wed, 19 Mar 2025 10:25:01 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm2081912a91.13.2025.03.19.10.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 10:25:01 -0700 (PDT)
Message-ID: <18173069-d12a-4292-8da8-0689e13e5dd6@linaro.org>
Date: Wed, 19 Mar 2025 10:25:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 39/42] include/system: Remove ifndef CONFIG_USER_ONLY
 in qtest.h
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-40-richard.henderson@linaro.org>
 <efeaf8cf-a6a6-4b9a-a54b-275eb0641aa1@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <efeaf8cf-a6a6-4b9a-a54b-275eb0641aa1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gMy8xOS8yNSAwMDoyNiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE4LzMvMjUgMjI6MzIsIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPj4gVGhpcyBpcyBp
bmNsdWRlL3N5c3RlbSwgc28gQ09ORklHX1VTRVJfT05MWSB3aWxsIG5ldmVyIGJlIHRydWUu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVu
ZGVyc29uQGxpbmFyby5vcmc+DQo+PiAtLS0NCj4+ICAgIGluY2x1ZGUvc3lzdGVtL3F0ZXN0
LmggfCAyIC0tDQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXN0ZW0vcXRlc3QuaCBiL2luY2x1ZGUvc3lzdGVt
L3F0ZXN0LmgNCj4+IGluZGV4IDZkZGRkYzUwMWIuLjg0YjFmOGM2ZWUgMTAwNjQ0DQo+PiAt
LS0gYS9pbmNsdWRlL3N5c3RlbS9xdGVzdC5oDQo+PiArKysgYi9pbmNsdWRlL3N5c3RlbS9x
dGVzdC5oDQo+PiBAQCAtMjMsNyArMjMsNiBAQCBzdGF0aWMgaW5saW5lIGJvb2wgcXRlc3Rf
ZW5hYmxlZCh2b2lkKQ0KPj4gICAgICAgIHJldHVybiBxdGVzdF9hbGxvd2VkOw0KPj4gICAg
fQ0KPiANCj4gSUlSQyB0aGUgcHJvYmxlbSBJIGhhZCBoZXJlIHdlcmUgdXNlcyBpbiBjb21t
b24gQVJNIGNwdXMgY29kZS4NCj4gDQo+IGkuZS46DQo+IHRhcmdldC9hcm0vY3B1LmM6MTc4
NjogICAgIGlmICh0Y2dfZW5hYmxlZCgpIHx8IHF0ZXN0X2VuYWJsZWQoKSkgew0KPiB0YXJn
ZXQvYXJtL2NwdTY0LmM6NzY1OiAgICBpZiAodGNnX2VuYWJsZWQoKSB8fCBxdGVzdF9lbmFi
bGVkKCkpIHsNCj4gDQo+IEknbGwgcmVjaGVjayBob3cgY29kZSBldm9sdmVkIGluIHlvdXIg
YnJhbmNoLg0KDQpxdGVzdF9lbmFibGVkKCkgdmlzaWJpbGl0eSBpcyBub3QgYWZmZWN0ZWQg
YnkgdGhpcyBwYXRjaCwgc28gdGhlcmUgDQpzaG91bGQgbm90IGJlIGFueSBjaGFuZ2UuDQpP
bmx5IHRoZSBvdGhlcnMgZnVuY3Rpb25zIG5vdyBleHBvc2UgdGhlaXIgcHJvdG90eXBlLg0K


