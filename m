Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801CBC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUirb-0000uv-EB; Tue, 30 Jan 2024 02:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUirX-0000u1-TE
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:48:56 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUirW-0005Zi-Ag
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:48:55 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33934567777so2869569f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 23:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706600932; x=1707205732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qEbnroK0LOdGQu+7rKiiE1W9k2xc9p7CfQf57yQIX4M=;
 b=dDpO3SFJezQPih4NedCDHpkb7pUMKLS4ZB99t8SFDPSxPmMt8iO8rg1WjPzaSSkyCW
 zJQ0XOlHMBl0A9GtQs0jnAhapfuCah12OBUaJD2y2YCF0SvRv/FiUJPpy9llkQkut6/C
 eY9P2zz6ow8x4seiI4xRuXx1aumKJuwMyVhoFYgHsZj3A2c2jHdL9wqB731f9gRsgKVI
 72tUYf3aKligUjRVrfpYzOdsZ0NAkenuadPSHf2RnJla0x3z+nPSvU+kmaraYBU8E5j9
 i79Md6MWI1xZTlUyNaUFKoLVnFISyaCdcRjQCm3BI37icSZoN0G/5lmc59abJL56Zqmo
 Z1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706600932; x=1707205732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qEbnroK0LOdGQu+7rKiiE1W9k2xc9p7CfQf57yQIX4M=;
 b=T24bXjpNRx+fBO496zcCGAaPmE4cLqQ0IUd/LvhjApRMUmwXfVjYDC6lFhtXkfj1o2
 8KlgHgnPc6cwfJoCdSwVsJRd1lv7Lv9AbDJan49ZlWSn9BJg2+AFuhpAnvCprrqKLr6N
 sCt23tyIauErJccQRrSgjdjTdOZwKHi83o6ojaZglEsCSaP3bTWxOdsxMvku6qxWgiro
 2iy+49+LtufvWM7K8fBut8P5QZE2gU09KjNrxxwAKDDsQtwkCw20j2DsqL22B8MKiAVp
 yo2qBlyS4pVBemHffG1QjOKwuTKEaV5DplyHalmTyTbi2hM7uTbVqEnjOsnnO+/6726w
 YWzQ==
X-Gm-Message-State: AOJu0YxZR8OXwGiICvU4AFVA8rYYKAwRcx2eB4BvsSO/MjHF5m3MMQne
 ymZjVOKj2bg/ovvDrs80LuwFni1Ie/6WA1qOljOMG5KqZcqeTf89wlzGurQEHWw=
X-Google-Smtp-Source: AGHT+IGKgGWO+ftAhUX18wzPQkWczHU3bKwWkog4Ih71idkf3aKUYtqZp72UZytkt59POfwN+2cONQ==
X-Received: by 2002:adf:ee89:0:b0:337:c693:dc06 with SMTP id
 b9-20020adfee89000000b00337c693dc06mr6808001wro.19.1706600932419; 
 Mon, 29 Jan 2024 23:48:52 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a5d5291000000b00337d980a68asm7624788wrv.106.2024.01.29.23.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 23:48:52 -0800 (PST)
Message-ID: <950918b9-29b3-4950-9e04-d66c5bdfbd6c@linaro.org>
Date: Tue, 30 Jan 2024 08:48:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] isa: extract FDC37M81X to a separate file
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20240129133751.1106716-1-pbonzini@redhat.com>
 <20240129133751.1106716-3-pbonzini@redhat.com>
 <AE14AC8A-AA67-4F69-8D45-640C93217935@gmail.com>
 <CABgObfYe8DNifSra_42L06bJ_ACuoTZ_yxNjUUkyuqROypiZNA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfYe8DNifSra_42L06bJ_ACuoTZ_yxNjUUkyuqROypiZNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 29/1/24 21:26, Paolo Bonzini wrote:
> On Mon, Jan 29, 2024 at 8:49 PM Bernhard Beschow <shentey@gmail.com> wrote:
>> Don't we prefer a macro for below code? While touching the code we could use it. (Sorry I can't recall its name from the top of my head and I don't have access to the code right now).
> 
> Ah yeah, OBJECT_DEFINE_TYPE. Not sure it's much of a win because
> neither finalize or instance_init are required here.

Bernhard likely meant type_init() -> DEFINE_TYPES().


