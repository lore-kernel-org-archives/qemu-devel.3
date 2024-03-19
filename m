Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B8BC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 12:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmYAq-0004Fj-IW; Tue, 19 Mar 2024 08:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmYAo-0004FD-Mw
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 08:02:30 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmYAn-0001aE-2i
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 08:02:30 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56b8e4f38a2so1278113a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710849746; x=1711454546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g+JSz7RmVBzMD9gasjzrcaHbChjkvSjPxa1S0zOEfE4=;
 b=dgQdCpwyt5IdkHHsYirxDoaDi/0zpkzStYRe12UWgRFtMXNDR/4U3eXwoBkIs2TXgS
 LjPxnndLDFT/cce34bYbu5xlDPSI/Vn9M5m/zOvPN8uhyDxK6TDOSbLSdB/eDaYeAaVQ
 wt6+8Z61a9/AOzlz/QiCevp5+D0KiYj2J6QsWBD37YAmJM9H8N13y7W6cGsIdGKUYF2N
 wAsCbYGLXM5Ghp5plpCW+d7FNRi8kLOtxbMvoBHytJwgY5UAMxLnmPTT4ZdaalC45fng
 tB53g1jge4k3sQbxD8McAqFie7uPqziGK3OKytGz23YHf7CN3QIrdU/1H85P+RoarXM8
 EE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710849746; x=1711454546;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+JSz7RmVBzMD9gasjzrcaHbChjkvSjPxa1S0zOEfE4=;
 b=VsyMWKPE/plqqf3D/NcPlkFraBnOluQCB8xzeq9lZibeauJpPya79KZ+KOfgSjzzfR
 mi9WH/Uj2xyUr5LHZAwReY/wVtJ+evFfigTFgJv3pUTaGgo8ha2YxuosyJZlQ5pO1SZQ
 22+3sKz44OaAJ8s14l4KWkJqWfc+L+QEA6F/Xf48ms9QkmbUN4MiCoF344a5v9d6WVNu
 Qo0ZEddyqzQ1a3GtSubfba63kwmSdmKMtDYihFz70Q33STy4o83fHLw+psEZ5W7deR+g
 K9W4jvO2zgGcZKWoQ/2inmoCIYegBRNNyCcDwUIxXCO8kteFGQNFlWo983+DdWJzG/XC
 KRUA==
X-Gm-Message-State: AOJu0YzHOPOPrURy8pWjd6Wy4KGU2biPMHf/nMovRGB7vVrrIO1tudff
 mbLmh78osXm/BPSCBHltKL/5Rz619eWMZZRaECaUsXSN0gxuEMv/avpiVi1ilsdlZEIdsCSGytJ
 x
X-Google-Smtp-Source: AGHT+IGTCLZFJnGYy7W0gRweOtChqGHjZehx4D0lvh1Qh3QIZcRdu6lrny7t5wbWApFlJxkrjylXVA==
X-Received: by 2002:a17:906:6898:b0:a46:d6f7:e8f5 with SMTP id
 n24-20020a170906689800b00a46d6f7e8f5mr1537112ejr.18.1710849746412; 
 Tue, 19 Mar 2024 05:02:26 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 y24-20020a170906471800b00a46be85684bsm2278612ejq.223.2024.03.19.05.02.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:02:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 699D75F892
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 12:02:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: KVM/QEMU Community Call 5th March Agenda Items
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Tue, 19 Mar 2024 12:02:25 +0000
Message-ID: <877chy5t0u.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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


The KVM/QEMU community call is at:

  https://meet.jit.si/kvmcallmeeting
  @
  19/3/2024 14:00 UTC

Are there any agenda items for the sync-up?

I maintain the invite on our Linaro project calendar here:

  https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMWd2=
dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfMjAyNDAyMjBUMTQwMDAwWiBjX2s1cDJscGd2YnB0ZGl=
ya3U1c2kwMWJsbW5rQGc&tmsrc=3Dc_k5p2lpgvbptdirku5si01blmnk%40group.calendar.=
google.com&scp=3DALL

If you want to be added to the invite list let me know and you can get
spammed by your calendar app as well ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

