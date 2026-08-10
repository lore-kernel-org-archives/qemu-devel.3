Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0C5C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtUNw-0003ia-GW; Mon, 10 Aug 2026 14:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wtUNv-0003gU-5X
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:06:03 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wtUNt-00012r-Kz
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:06:02 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so3407329a12.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 11:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786385159; cv=none;
 d=google.com; s=arc-20260327;
 b=cKwm8hux3mnoQ8qjtWQPjXfVGpAgRrTVpXo219pZtBMNViBu1CtJEW8zgfPJyMFfwU
 oxdDnvGP7QcpTO+D5+mQED3g0oODyfWNq6GGAa3l6akpC9eJe53aS7wqJAoeYeit9xaA
 1aPhHUEsz5soxaE9IoSosLU51DuwEbflH9/sDP+Bi/9Xvzi5pfQVufU1AkcERu8jB/ML
 aSXwyC7wPjQJ+LmkFUPca9SgtuFrJ6/RnVTicUVVcsL6fSdfIZxh1LrlwwLKiHwXdUfz
 41GA9LUwKuzHTWg0sUb0LTChmGpwhYc21++iE7PfrwrDm1e3T7rOeB/9HuOtAaa1L1kS
 5BpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/FtDOQe7PeStQmatgsbG24MCnlJ84WNcp4JKodWVUWc=;
 fh=vl422cnJFKKP2MwKcrdH5QJoz/LQXbnGOB1it6iZRE8=;
 b=c5iKku5iVLnmmvmjYl04615vf5o0CfYaqKqq8CDpW6l4Lgy62IwEk/IGbRCFjcMnY4
 xkP72m/lS2u/p4wr1WbXBwAF6fhoGW5yC1V1/ok+PuSEUzrvMNnJI+9auVYrABceawlN
 WMIco0+a96YRuvW5bFPC//6eSVTM8I7D1GJ033B8W+ZtPVd6kWXSMoNjNXH3drC/Qm4p
 zyaenzN6KmL83buYW7DCVDD7dMnDXQAJdgAmcatxWcSWroSLi5Yq4gKKxY/IuLpLVtZv
 HjTUVgemmcEPnvbKrSB6JamN3DEyiTw7s5DKFai7UncQ48Xjlmzxpv6JevNWfBBNa3C/
 XPSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786385159; x=1786989959; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/FtDOQe7PeStQmatgsbG24MCnlJ84WNcp4JKodWVUWc=;
 b=JFiBB4wuXj+PrRTvV0CjbkZM4EtLX5VYj4+6X0eXUjoC3m3JryBukhGC7qER+2zlgV
 iUUXv2JYOXFhvyl4e/tVu0SuFAX3Mj0YFtbiu6ndUyh4bt3ssjgtomrD0/0Fk+z0PF+A
 Zt+sZBR4z2F6jbrx8qtBENlq8koVdQcz93xHiG0XcirHq36RUU7f5nNSd98i4puNOEI5
 CwYMP0QukQyzPmYnXGhdMOk8+ND1R0C03lMmjQ/Fdr5oZsN4JRGjevjXTx0I+mdcvSDA
 bR4hHHyPNPJgzBMo4ZVlp2X7EUe12rsKbgeEtjJR1aY/4I0E/c4HesnpcGAudeNjdkYD
 aDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786385159; x=1786989959;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/FtDOQe7PeStQmatgsbG24MCnlJ84WNcp4JKodWVUWc=;
 b=oWXGLGUp5AQvmH1bUV1MsrcrhefuZ/arKZSnjMtY9tKbrNA7gyHmXYawQBrpe0XIBe
 4m+rF45IG3Jq1lFP8ZB/VqgQIvdpBdWyv12RONH+StIrQcaHeVUdpe8qu9msq2itOBTe
 ssT2CFwoOCTHuclQEkL8CaSug4bPqcw/x8tPErbmrj10XfYGXjNLkuRtPVPH8Mf4Dru5
 O5stub7v4EC+iCw8CQccdJHLl+nf8ISw9EZTQCrNZPQRNLk8BGcu10tGOTg7bslRIGEy
 1xCenlRVAl9KadOzcUuHREEcHwWKf2w023+t9SVHoDBtjVvelMJjcWSDme0Mla+Iu6lY
 Yylg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rre2mX+ZWk0I0QByYyh7TuPHUIe/XLdHdLddD/AHL6uIxmerFVEkf2SU9zLjKJAbLqkReg6kMB11b2L@nongnu.org
X-Gm-Message-State: AOJu0Yz49pgM4AMC7hLuCwqw/Q4WV9CqblhKFjNPlA+T2uoUJEUtWvFy
 8HDbIUpQt4c0oyrmxUDRekyNP3VLYtPwi7HZTBzYD714b6wsckpxkuj6IaQFOxu6zxzDaduTsoX
 CsdH0wdH2WQkY5/T/bw+AA/KTpZItnf8=
X-Gm-Gg: AR+sD13r84KewgWS9tCjUusw9Y9Ct32aqxGwewwMG7IruPipIJRm3GGibvI6j9IviIN
 nqfcjsXi7pP2qt5Z3PxmgrjfKKs0gwWjxMSegEeByJzo3PoUE8E+bgImUNh66de7YhXlWw0/iiF
 pmDnIddVTFNpkslcBsGETUDPjXumuPThoFENQbbnXmwtzI1iPbHqoV7yu4slg22M8FOQdQeUF7h
 xVEuYa/L/DM8kemYeF94U3HqPCmKseybrsC94rBEGcsBt0Bn9fNp7/w1oWGjJ5P7oTnvMWHfdt9
 jNGrEARXdztxp+06JzWYdN3VSmdgzF7o5mqBXVj4KYKodxZCvWLlrr8gMXZ9/LoAFPMShlyUhuT
 SLAgjdQmCFiHK
X-Received: by 2002:a05:6402:44c3:b0:6a1:f95b:8cef with SMTP id
 4fb4d7f45d1cf-6a355d641a0mr1806169a12.4.1786385158719; Mon, 10 Aug 2026
 11:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260730081325.1816193-1-den@openvz.org>
 <20260730081325.1816193-2-den@openvz.org>
 <CAJSP0QUnp4=pPYQvGvTEoBCndvJb0o=Z0RzehP30KKK_svyXCA@mail.gmail.com>
 <f271fcff-4428-421b-b2b7-472cd8bf3cba@virtuozzo.com>
 <CAJSP0QX8JnTSWHQeQrH5dKHeC4oA9CMTzHAZNhzt_8gKorJ9Gw@mail.gmail.com>
 <3f84a950-d079-4e05-a3c5-daf81672b3e4@virtuozzo.com>
 <7239bc2e-b180-42ab-ae56-454557cb3194@oss.qualcomm.com>
 <20260803180228.GA365806@fedora>
 <CAFn=p-abWtYqGtCbH9XTK62oEPK=vLPjy-scwqR+crXvOQ3RrA@mail.gmail.com>
In-Reply-To: <CAFn=p-abWtYqGtCbH9XTK62oEPK=vLPjy-scwqR+crXvOQ3RrA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 10 Aug 2026 14:05:45 -0400
X-Gm-Features: AUfX_myq7fIebZVEHjw9x5X0loEDedusrADlIRkxRWoaqX9avGPrduR5S4qdXFE
Message-ID: <CAJSP0QXX4h-P+pS86++0WGat2V307d0Gn2GRFa2bgm5cBsYwWw@mail.gmail.com>
Subject: Re: [PULL 1/8] MAINTAINERS: add myself to IDE maintainers
To: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Aug 10, 2026 at 12:51=E2=80=AFPM John Snow <jsnow@redhat.com> wrote=
:
> Please, please do go ahead and take over.

Hi John,
Thanks for the response! Do you want to stay listed in MAINTAINERS and
review patches, or would you prefer to hand over maintainership
completely?

Stefan

