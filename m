Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8F8E7719C
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 15:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWdfT-00056I-JF; Sat, 11 Jan 2025 10:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWdfR-00055x-T1
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 10:44:53 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWdfQ-0005zn-8T
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 10:44:53 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso28975465e9.2
 for <qemu-devel@nongnu.org>; Sat, 11 Jan 2025 07:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736610290; x=1737215090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L447D60CgUZfIyvkLe7HDbo13PCbviM1cAXNkP9qux4=;
 b=A8u8l/c4LX7qQKhxzI4Np0ukTHY2nSMbf3fCwBixMEE0eW1ZPetpvrBKcKEfLBKcVI
 c3cGdodJhf6q5rZucKgDoKpsR+5KNulCe1l1tDk9AZY0ZnFocDQN7DbiJdRQop97Nn7Y
 Wasp3G+lK8o3PrJISXaoMuLL8fkthe1D2KIbqShVnIluh8M316Rhtm4MlJvD/3dqBzGa
 B2WMM/3rVBHsMKB8Bp9gFVW6H+2plxrOZeEJLtapg2W48rGVk8BnWIenAPb4/PugU8Qg
 qR0FoxcgKzxrH3xsLfv3wPdvD6TaflNzhfBI77WStnSy7M4w3lnPJvRar49iUKG9EGUk
 P/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736610290; x=1737215090;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L447D60CgUZfIyvkLe7HDbo13PCbviM1cAXNkP9qux4=;
 b=UYNXCbqrEBTkqDbsa297lYQ065UxDTng/EKuDTE+3lUdwnFwIgQ+cWQaHK8C2YuOIr
 rdTugeRIKNph6BF9xyUBK/PlU0SVyo/1kZnC2NRjjFIQr3baZKSmEh3XETo1G4QsrVED
 2DXELr2sqDR4MeFf4MsAncBSHr1rnw9UxGltWpKCIzCb+IZ4i2Q4OUpiVyAsVffuOydi
 eJK4o3obTULinIRPar6Poe+LA3juGhIP4eqfVy2r7QBtdPdqnOD4nyTSb+qAq3eViyWL
 bprVEguQfcBSQ99FufD61dgy+OxqWjq8cUYsLuH8Ck1XQMH9Wg/bZ2MwubZ/5QKjXH89
 oNgw==
X-Gm-Message-State: AOJu0YwqxW257tj1xgu9UK5tB0p8TNnRNCNI3I+w3YkXp5KxDNRSMLeh
 Of27oxiPJu6Z+bHKrlTjMv/o57DkUcyvcZykvpgAw/eUI65uKxeqsAP+vt41xcY=
X-Gm-Gg: ASbGnctHlCQFrNHfsczJFx1satnIPFEH6cDbN/RsWerM6cY16QSEZtFpMJTiZwYVprO
 wVmO+mw45sgbnWWJ1Tkc6f09v8AI2dh70T5wzZI9Q0+6sDEgFStdNWGa6fpQC6dAF3dDtTMqeMZ
 r1h9szcfCHcSm7L+/NRcbjb+u0N36q6HaWHF27YAKuBYvnTSYM5CGRRlUGhD+OjWU9No35vNxoK
 6r94B7Zra1Xt6+ajjqz8sRhcLE//n6VfGdXBQK9Isxi2KBRqbA7hRqOPK3ReauHz0ZDBxN1H5U2
 6oLy+u0FsQNuKxzWXxwgG+wP
X-Google-Smtp-Source: AGHT+IHqL/oF398wwtdAcWF6l+CGmejW+JHMl946fjuUf4hHX1mXBqOWlMrPNoiIkHcpdZ6MqM7kfQ==
X-Received: by 2002:a05:600c:4745:b0:434:9c60:95a3 with SMTP id
 5b1f17b1804b1-436e26c4218mr145018485e9.11.1736610289956; 
 Sat, 11 Jan 2025 07:44:49 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc14ebsm119112985e9.17.2025.01.11.07.44.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jan 2025 07:44:48 -0800 (PST)
Message-ID: <1e168f4a-c0c3-4beb-97e9-93200d3c045b@linaro.org>
Date: Sat, 11 Jan 2025 16:44:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update path to coreaudio.m
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com
References: <20250111-maintainers-v1-1-faebe6ef0fec@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250111-maintainers-v1-1-faebe6ef0fec@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 11/1/25 07:42, Akihiko Odaki wrote:
> Commit 8b46d7e2dc8e ("audio: Rename coreaudio extension to use
> Objective-C compiler") renamed coreaudio.c to coreaudio.m.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Oops, thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Queued.

