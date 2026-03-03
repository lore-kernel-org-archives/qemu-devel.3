Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2697E67A62
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 17:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxTcg-00019q-DM; Tue, 03 Mar 2026 12:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxTce-00019e-8r
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:33:28 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxTcc-0005y9-NX
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:33:28 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b934fdced05so788629466b.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 09:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772559201; x=1773164001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vl4hVoVTqFY3i48nyfeHK2ecdevDsv0c8GqXyhaVmJ4=;
 b=ezW7TUAtd5qmIPzxyX5SlKqP3D+wUMV0CnJQNpDV/fKFBMtQIDCQq07H2VdzbWz36h
 LSDwn2j8CrvLuWz6fxkStfyRcU2tsWVs3al5ZVchyT3Q5Xz1w9WoSIOAsJba6YabLFZ3
 7RzL+bPX1MN1L1RiiW5PUkJ4sB9kkHrY7faIqJmpObF5PgswZmycUb3+oqIJNLPFfEsF
 uk/6iJaup9kWHvpK6kjI9l5gZMaDG2z8VS+Cc6kbfKDFK6Xhk6Xj7wnHK8bjc4383fmq
 04cIlTmtsIXsuYZynhY4M08OdRRby+uEJfatOW2flJKqHWOSLfAUcMKN5iq88vo74tW0
 LQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772559201; x=1773164001;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vl4hVoVTqFY3i48nyfeHK2ecdevDsv0c8GqXyhaVmJ4=;
 b=h2sIHafR8Yeh/muyccQsaxR7BTyzDrEjuej9z4fRcXChyF84hq1j0sNXAIvFo7cb20
 RUkLXfwGFuZqjWqXiExZAtm0PiXUJOFW7fCIuO45DfwiXvoyQkksdWm1BoJj95OPVObE
 jG/GSKhvGzYPw4Jq2NiRGEvZvjpfq+zlM3u1SK52GLAJ7tNECIub6taM96oq4KPI0iYc
 24G7eksIcsIMXk2L2p2f/J2NhiMHnCZXNUvhvAQnpS+2wHmM4yO23No4i/lAZ8cIMJld
 a23+Uxcc4Q0L8nepAtIanwNnRXzAQOfj9SJLfR6nAEnguYl82Azs+2s9QB0DtNO9KUJ4
 uxPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCViGP07C2RfcD9djmNETIhDnrH0SuRysCIb133TU7dOsBOtfnXBOabSu9xBmbO9GnIUKYvKwI/635DP@nongnu.org
X-Gm-Message-State: AOJu0YwXK28X7PS5vHNLa8i/cSW3b5wkPowq9+SQBxd1ZNTnsAZ5ixDn
 Dx5hJtEZ81He4bVBhBPCSZJDcwSlp2drRaQ4AMO+jwvhpTe7b3gRkc4eJobVrP+k7Nk=
X-Gm-Gg: ATEYQzy+fsqdGOrGp7/jAPttuB/9XFJ9a/m0rRf+S8pIWmtPQYSWYctBF9cDh6KwkGB
 foxoZI4C0qjTliYIEkjwe3p+5TgozvqjYQn/xXgbsplKiWYYfy7M5EgYLe05HqAXMSmUQEww9ea
 +Xp/iF27gKVH5hJqPQgisvQREuVejVibwmnGDyPUIvZovOjVEzippktaVvXIADKKu5BFFCGInfP
 pbywb2/J+FfB0f6jQpY5PUVQyd2+sjKr9ob12nHkst8xiiHMrWtyq4BeQQM5Rn6cS3FsMiHNgae
 UEcBC7l7Lku8bDGw1RXZDk0obsYDDePd2DU8qToFylwJ0wV1IDNtiLsTXpKLjDtn/p+S9PyO7xt
 AskWJWdJXNSrVymx1aGK7K1mf6Ehzi103hYSm0nkoimy4poL+hBFqzEVSvsZoOQDVbGAk7g6qvj
 NXk/lDiA27jWqusJboQbPo8QEYGp+kbBRKDg==
X-Received: by 2002:a17:907:1c93:b0:b93:c5a9:a5e9 with SMTP id
 a640c23a62f3a-b93c5a9b9d6mr393395766b.4.1772559201322; 
 Tue, 03 Mar 2026 09:33:21 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66005566561sm3243826a12.30.2026.03.03.09.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 09:33:19 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E00365F7BE;
 Tue, 03 Mar 2026 17:33:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Yiwei Zhang
 <zzyiwei@gmail.com>,  Sergio Lopez Pascual <slp@redhat.com>,  Gert Wollny
 <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan Singh
 <gurchetansingh@chromium.org>,  Alyssa Ross <hi@alyssa.is>,  Roger Pau
 =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,  Alex Deucher
 <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6nig?=
 <christian.koenig@amd.com>,  Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,  Julia Zhang
 <julia.zhang@amd.com>,  Chen Jiqian <Jiqian.Chen@amd.com>,  Rob Clark
 <robdclark@gmail.com>,  Robert Beckett <bob.beckett@collabora.com>
Subject: Re: [PATCH v22 00/18] Support virtio-gpu DRM native context and
 MAP_FIXED API
In-Reply-To: <20260303151422.977399-1-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Tue, 3 Mar 2026 18:14:03 +0300")
References: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Tue, 03 Mar 2026 17:33:17 +0000
Message-ID: <87qzq0rf6q.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> Hello,
>
> This is follow up to DRM native context v16 [1] and MAP_FIXED API v10 [2]
> virtio-gpu patches that has been reviewed previously and were waiting for
> a new release of libvirglrenderer 1.3.0.
>
> [1] https://lore.kernel.org/qemu-devel/20251116125641.2255794-1-dmitry.os=
ipenko@collabora.com/
> [2]
> https://lore.kernel.org/qemu-devel/20260118162856.223796-1-dmitry.osipenk=
o@collabora.com/

Queued to virtio-gpu/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

