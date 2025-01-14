Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2722EC02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 08:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXcAG-00089l-Sx; Tue, 14 Jan 2025 03:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXcAB-00089B-Sh
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 03:20:40 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXcA9-0002Kl-Ut
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 03:20:39 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d9b6b034easo5398664a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 00:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736842836; x=1737447636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01UomosEGDOz3UpdvVJNQC7YKgU7w50lbDQjtt/nOxQ=;
 b=VYf/Q36iaovgswIY8SimarezosZlj38ITiFPfM3YEZO04aUSoCjfdRoeKOEtspfT4/
 Jr9n29AiK2mXOcIqjhiJfGJcrqLDPNJv1UJXXUpXEyoZ4/p1vQur6QwSLMNR0HIifnSf
 h4lpKUIt8GgsF9TKVxkxl0RPTlJ2/tTwdU1Z9msLQvd5Ikm98S4vCm3MdM+xT8zUSUNH
 LCLhi7PHbvASjMzTP/s8znadXUfVt0uTx2MkhQRsf+mu/+CDi0ipmNamtQR2NRJTzj9a
 Ji6JRelWeBukDotBsxz7KxK3xbrD+2vFp9piAqmLy1PJlHMy21ZZ+cTE4+1N2q06jtBf
 UhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736842836; x=1737447636;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=01UomosEGDOz3UpdvVJNQC7YKgU7w50lbDQjtt/nOxQ=;
 b=ZaUPmLNKBcJkNznbnhENhZsVdBcc67Xu3alQXQ3/TrHMAQ8vCRQSLAy8w0sTOla9/T
 nuwi+897SxPuyQIVZkkSFa4l31xKew+cYGWI1iKn/MvQSuVCfYGdu6ZkhPyWBOqRj4to
 HRKIkd/4ok2Mn9eJlEp+pmLSyR8G9V9H3R247zL714LHQoxD5CjyGQD8tRbto3Wm/p3Q
 vrqJcV+pqFfkdRUxRP78ThrtUS0Ud3Fa+JYPFtckT1aqvYHzcl2pDyPCnudybeLDW+nr
 Qeo/ZpwVbL58ToCeZhesRlcEZve9ZiyLF4HbUpRDcEE2KJCj4ITvlKCFjQiA/98h6BVW
 pgdw==
X-Gm-Message-State: AOJu0YzSPNuQntPtTmtKIqioKObgF/HOhSno4+FGXVaNq+GJT7uvIUNV
 60jUskK0GTHlH+okU2j3cNFNrE4kpudkwTfxvI4RC0lF0AbUftpgZGkOoCNoUfg=
X-Gm-Gg: ASbGncsM4m9o8ZKAfC3PcSGy/Dp3c9gke2robOIEzwM9mt2j/gpV93DTLQRdkj8uChG
 Ts3AEytBzeTkXANcbYnZrIoXJ2uVyNYoibM0jtK8+H+ooPcCf1nDHEoqvbLIaqKBVVued3cIUkQ
 cJVOrM9edYEq797yJ7q7I82N6htz9eU19wnJ6El2KHpNlcavYU8Nvi6he4ELdqFTJLdPlAp4T+x
 vKAd0lnjGYcm2bqfypQA61uwbj7EQN16vcTvKXE33vkmVGObshDSS0=
X-Google-Smtp-Source: AGHT+IELYOwiQuNR3iq/cPvMjq8VXH2HAQNwzh/dNvatXyZFoWfqhr6zKnYsdeiKJTEU8vgRkoooCw==
X-Received: by 2002:a05:6402:3553:b0:5cf:c97c:8206 with SMTP id
 4fb4d7f45d1cf-5d972e4ccfemr22464078a12.25.1736842836016; 
 Tue, 14 Jan 2025 00:20:36 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9900c45aasm5787704a12.28.2025.01.14.00.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 00:20:34 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AFAAC5F87C;
 Tue, 14 Jan 2025 08:20:33 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Markus
 Armbruster <armbru@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Da?=
 =?utf-8?Q?ud=C3=A9?=
 <philmd@linaro.org>,  "Michael S. Tsirkin" <mst@redhat.com>,  =?utf-8?Q?M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
In-Reply-To: <20250110203401.178532-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Fri, 10 Jan 2025 12:33:58 -0800")
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 14 Jan 2025 08:20:33 +0000
Message-ID: <87jzaxkdri.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> For now, it was only possible to build plugins using GCC on Windows. Howe=
ver,
> windows-aarch64 only supports Clang.
> This biggest roadblock was to get rid of gcc_struct attribute, which is n=
ot
> supported by Clang. After investigation, we proved it was safe to drop it.
>
> Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and aar=
ch64
> hosts.
<snip>

Queued to maintainer/jan-2025 and testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

