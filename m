Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689DFE77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 13:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVt35-0001dm-Kn; Thu, 09 Jan 2025 08:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVt33-0001d6-FU
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:58:09 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVt31-00066v-N5
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:58:09 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa6c0d1833eso213165166b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 05:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736431086; x=1737035886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OW8urWt7SG0qMlxfNzJ4SZGkN34RKIMmPoQyon9w7a8=;
 b=jM96EbsxZBZ+ttg3R6TqBBfXyPjMEf9meYcj5e1b6knxmxAFGTUDpNK3bLrPTGqds4
 IpAVIasacAEGyv2yZwvwlETSSGnOH4Y05kneUoP8a9dcMk5ltBeoLyMksetbkCL++BZ0
 F1LYPPCUkGOOtZ/gDBH6iL3MOIxjd4++mODLchgLpUPxX/T16+LIIsRQ40Wy3iPyD4JC
 GuX9OXQzkczQAnKb9W7TYTnqSG5WBQEa80DgFLlyoNc9V70L9S2nwJJyLb4xT4p/h/5e
 OEflb87E4vVmI3SMUViLBepQhOTOqvxLSc73ttiEB21Kz7JeNSs0wUuaDMFr48HhBUnk
 ZpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736431086; x=1737035886;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OW8urWt7SG0qMlxfNzJ4SZGkN34RKIMmPoQyon9w7a8=;
 b=aiQvlJLbc2dLT0NHNj48XILeohMh4Hc36o/A7/EOmdTrOdOmM5kFmr2uT9k24YAd4u
 a26LxCX6h9iIQQZAZPfhMU4BzB0w+al9fMcjGYIJkhVHuj789jGmzw4xeS+V29DikEzC
 TEhKSlJ2d9flabZd6UIrJlisPQ3MSCfrbqlhFPY2XoVwW1vD8gaelZpNg7OQJyXlStv+
 RdmRwLOv9D5vG/Eu2Baowiufg6DKXmdyFjMViJAqNQDmJrrP3O922PeejCMf3NiQOjnn
 gI82lz2qB9RMxZsSLZwaanSqOQU6NAmTI9r5+CPmqlctkY3sE58k+r1sfJdIgdT9ompS
 Lt5g==
X-Gm-Message-State: AOJu0YxOo/PIZbi080AqxiOEuTXurwH51XLvHmW/4hSCcJ+gb72GJUNK
 61WiNN2ATqH2GuB+hGP+TUb2HNaee48sdnOQVTcEtabP4BIgS7S8Pcy2pksD+R4=
X-Gm-Gg: ASbGncu2wbubUigHFBQKNzbngdbmpUyRnS3tUXPpHVGI+F2TNB1rPipyBj+rMoNdmBR
 WpcMXmMFMiv+ftFrlyOeIB0yhVY1sLKShctFPJsbhkYX0LgYZyiAAq6SoakmdfxbvjPq6so3o9p
 DSVp94EMoss/Rmh9logYv/Z95Bv36hqWyDTXBvFHiQoeCS+9w1D4YH8oEHcqFj5FfVM0PtwDNtT
 CAZGfGSLDbf1IYo4f5Ta/dyLls5uUc+MQZL1XgGRIimnr+Py6u4elA=
X-Google-Smtp-Source: AGHT+IEodgYHQ7KyJeUf6x2EG3dMZiSUVKNUzrXXem+fGdl56jR5nihlSdh9vzpEE6hPX5Ro7eAFcw==
X-Received: by 2002:a17:907:3ea3:b0:aae:8491:bab5 with SMTP id
 a640c23a62f3a-ab2ab73b234mr610658766b.26.1736431086019; 
 Thu, 09 Jan 2025 05:58:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90dacf1sm75876866b.63.2025.01.09.05.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 05:58:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C5D5F5F75D;
 Thu,  9 Jan 2025 13:58:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v3 03/11] plugins: add hooks for new discontinuity
 related callbacks
In-Reply-To: <18b8687e6310a68283b8b3ed72ad38479114bc51.1733063076.git.neither@nut.email>
 (Julian Ganz's message of "Mon, 2 Dec 2024 20:26:44 +0100")
References: <cover.1733063076.git.neither@nut.email>
 <18b8687e6310a68283b8b3ed72ad38479114bc51.1733063076.git.neither@nut.email>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 13:58:04 +0000
Message-ID: <87ldvk6qdv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Julian Ganz <neither@nut.email> writes:

> The plugin API allows registration of callbacks for a variety of VCPU
> related events, such as VCPU reset, idle and resume. In addition, we
> recently introduced API for registering callbacks for discontinuity
> events, specifically for interrupts, exceptions and host calls.
>
> This change introduces the corresponding hooks called from target
> specific code inside qemu.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

