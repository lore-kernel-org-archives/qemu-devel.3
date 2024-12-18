Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EC5E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxRl-0003QL-Kb; Wed, 18 Dec 2024 12:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNxRb-0003Eu-1v
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:02:43 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNxRW-0001NL-PN
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:02:40 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so44395565e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 09:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734541356; x=1735146156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4oi1V5/2EqfFiyQXMNJY799ulFtXAnzfv5cyWO1EIjs=;
 b=TAfK79GgiOl5KkP3weHL7MbCSlUMAi3h5ynlpS0zqIjrntrbN6VeznL8EdON2O5R1O
 tyVJKiqbebkk/+Cx2B07oe8SUAAydtdKItZyFrHjOvmuHe0GB7GdY5luy7QWm8ClukDD
 VEDd5AaqlHwxxg/avFZFRIQMBWozA6XtjGCuiEFYDV7KliOni+W6tRPWUOVhldtCv7Pl
 CluxelTXy5NaPMzJoI2dXswsIew2lRL2iBhdT8HJKMbkyao9Dnlxxn3MJzS66IhlJVKV
 n0Rqd4/rZ3sYsJgYuhvlxoHgJd810mEtd+sFznXXPepWvcx8N8f54B7tfXDlkafeCHUJ
 GXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734541356; x=1735146156;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4oi1V5/2EqfFiyQXMNJY799ulFtXAnzfv5cyWO1EIjs=;
 b=XjoHG1ml8zvAIAgwa0uz2hjerAeU4BVCELVLwTbmFb4+CEZfCzfgZe9nRK4Xsxxprh
 53DIxBKvboC9b3FWrSGHLG7vBY7EYa6ZdPtAyZantmZOWk1saJLZC7klSNvlWqZBjfNx
 EhfXuCSgnuOsu+ScQHwiowvvWsmniqBMqpHcltkAyx/qJlKcGMm8+iHOrhhEiLmXeH9r
 Uh947BiJqM3R41/zvBYmbrLqcZQfCTH4Ogol+aAn//KBzJUNKn3NYnag3kQ7yvDYh5EX
 dZiffeVi4kd/1L9NfpgnMzw++9I2pqQlGGWHm8NIkK+C4DFjZUR/hIRFnBqM9wJD63u3
 +u8A==
X-Gm-Message-State: AOJu0Yy8H9esJNO0WBQtTsjBNg1dxORtPUTnVa1F9NIFRgn/iaSGieYQ
 0ldOiHpLMn7SxFeebdcl873p9HvE7SOVD8u0+m+zbQciGBWZtnlB9j8ir6FpMq7l6Sap2O1/p75
 UflU=
X-Gm-Gg: ASbGnct7UGvoteWyQv2+9hzYf2aOCi6Oe0jEzj9P5jbnPf9x3tkIvQ09CGgq2VbK0Gm
 qIdM2T9OWrAUl7mJEQvfUSkWDHyU3a92Yji540X09ZXxWudcOgeb0dwmyOnpobuNnXz1oMBrlvC
 1WJRQBcQcur7lnULQMzIqP8aIKpmNNKXB1HiSVauv8RKXuUUFcBvaMCjvzL+Xr0inQjYJzeWoVp
 IrqYemxirdLIodoePsf2+ipA8yLUwSggpOoAmGPRh+nIvtsDsIUnos=
X-Google-Smtp-Source: AGHT+IGrYSN9Hep9RC/lEJHNnaqSc0mDYT3c2GE6H+mN2G34BcMXFcti2eo90mraZu/iq4qOcbms1Q==
X-Received: by 2002:a05:6512:1254:b0:540:fb1a:af1f with SMTP id
 2adb3069b0e04-542210255fbmr119120e87.39.1734541342383; 
 Wed, 18 Dec 2024 09:02:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aabc80d4178sm334725466b.28.2024.12.18.09.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:02:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B40175F796;
 Wed, 18 Dec 2024 17:02:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: qemu-devel@nongnu.org,  Jean-Philippe Brucker
 <jean-philippe@linaro.org>,  Mathieu Poirier <mathieu.poirier@linaro.org>,
 Leonardo Garcia <leonardo.garcia@linaro.org>, Markus Armbruster
 <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: CCA capability qeury QMP command
In-Reply-To: <A96F9591-F80E-4193-AEFF-5E23B4E0FD5C@linux.dev> (Itaru
 Kitayama's message of "Wed, 25 Sep 2024 17:44:21 +0900")
References: <A96F9591-F80E-4193-AEFF-5E23B4E0FD5C@linux.dev>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 18 Dec 2024 17:02:20 +0000
Message-ID: <87cyho53hf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Itaru Kitayama <itaru.kitayama@linux.dev> writes:

(+CC Markus, Eduardo, Marcel for QMP API)

> Hi,
> I=E2=80=99ve been looking at the libvirt code to add Arm=E2=80=99s CCA su=
pport for
> some time and I am wondering how QEMU folk want to implement the CCA
> query command. Any pointer would be appreciated.

Jean-Philippe's latest posting is here:

  Message-ID: <20241125195626.856992-2-jean-philippe@linaro.org>
  Date: Mon, 25 Nov 2024 19:55:59 +0000
  Subject: [PATCH v3 00/26] arm: Run Arm CCA VMs with KVM
  From: Jean-Philippe Brucker <jean-philippe@linaro.org>

In that series the following objects are created:

  static void rme_guest_class_init(ObjectClass *oc, void *data)
  {
      object_class_property_add_str(oc, "personalization-value", rme_get_rp=
v,
                                    rme_set_rpv);
      object_class_property_set_description(oc, "personalization-value",
              "Realm personalization value (512-bit hexadecimal number)");

      object_class_property_add_enum(oc, "measurement-algorithm",
                                     "RmeGuestMeasurementAlgorithm",
                                     &RmeGuestMeasurementAlgorithm_lookup,
                                     rme_get_measurement_algo,
                                     rme_set_measurement_algo);
      object_class_property_set_description(oc, "measurement-algorithm",
              "Realm measurement algorithm ('sha256', 'sha512')");

      object_class_property_add_bool(oc, "measurement-log",
                                     rme_get_measurement_log,
                                     rme_set_measurement_log);
      object_class_property_set_description(oc, "measurement-log",
              "Enable/disable Realm measurement log");
  }

So I guess we could probe for the personalization-value. However that
seems very arch specific.

All confidential guests (PPC PEF, s390x, CCA and x86 SEV) seem to set up
ConfidentialGuestSupport with the ->ready field to true and a
confidential-guest-support property associated with the machine. But I
don't think that is currently exposed via QMP.

I suspect from libvirt's point of view we want to have a common probing
for CCA capable accelerators before we dive into architectural specifics?

>
> Thanks,
> Itaru.=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

