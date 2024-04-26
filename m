Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB52C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 05:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0EPu-0003Io-Sx; Fri, 26 Apr 2024 01:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s0EPq-0003Gv-P3
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 01:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s0EPo-0005QK-Q5
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 01:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714110391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6qVQC4gDiH9r9i+pddTQyOY4bjxDBIWGXbOd3d1bGQ=;
 b=N6qWDT7A9qXVighoTuw6nwhpeVXr/piNezFm+fUdMfNYOiXlYokcVPMaUrazTU+IMD476K
 +RHdrypABJR4/zTf27Tdi4ANLxOLRpI0LIkhh449lCc+inmEql7X37/mILX4LFzcH+nhD8
 NkzlXEEIU1KHPfmSgDgmiE+owjx492c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-F1plbGxjO-qtkalGNJZcFw-1; Fri, 26 Apr 2024 01:46:27 -0400
X-MC-Unique: F1plbGxjO-qtkalGNJZcFw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-34b0b409775so664494f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 22:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714110386; x=1714715186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/6qVQC4gDiH9r9i+pddTQyOY4bjxDBIWGXbOd3d1bGQ=;
 b=UA0EnPQPsZh9fhrsai8yf0wbRiA6gDHb7sme6mczYX2CUKosF3//TA5lNHWrGxb4KA
 iXphleLojbaEAywG6tSGspuBDQ22ClpkzDf2TBlRGERt9skj5wto1Ksu4568vDW2SmDz
 tLuLbYDs6KvyBUWjWO4yIU2+HPDYkirvgi2TWeNYFkOTRFXuKp8dtpPOaAUWctSkt4LN
 4eMEff28tT33sUsW1ZSjYX8qMiZa+adWwGUOVWs49R7NNXaCdVhumlZoowDdyzTM4GcB
 sMZkGmbFcFwSTnLjxFl81/hPKh6yrdaby1bKU7gkgGPTedEdKuxFFQ6jVwdPtiozuZt9
 zTOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfhUuyFuNY2+Vrs8XTPtgqPXKsE02YSpQxOF9TVQCiqaEFFRSr3zUnZd2AycLMk1HUHnH+yTHmBl0JMq57ULhgwGb00uc=
X-Gm-Message-State: AOJu0YzE1U36kYQcu4+sqwLuTe9T7IlEkKqcM0WZWPNGlZk+wA8L5OzJ
 Hb3vYuVjklUfW8Bfj5FZLxqbXOV1XDnhAmRnr91a6L9TCcFG6GP0SH7vDEiKH99P0HhP2bJ/H4o
 ii3CIY3qGS0cUf4oeQimU7nX1zDDR+pDDhHhORTgHH+1orbOKYHVq8ORgucUEvBp0eWdmpUpucE
 sIGOC3n/Fd7w9TZMh4mytbEw/6CZG7qwD8tsI=
X-Received: by 2002:adf:a3dc:0:b0:34c:213a:e949 with SMTP id
 m28-20020adfa3dc000000b0034c213ae949mr1031318wrb.60.1714110386236; 
 Thu, 25 Apr 2024 22:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqODPJKBYH5ASLIFfXJimwHdiBE+MAbCNaAQSrLD8FH8rNzMuDUPJ1hxxmr/ZdAz7iNKfYnWSPHl490kQP0AA=
X-Received: by 2002:adf:a3dc:0:b0:34c:213a:e949 with SMTP id
 m28-20020adfa3dc000000b0034c213ae949mr1031305wrb.60.1714110385932; Thu, 25
 Apr 2024 22:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240419195147.434894-1-mark.cave-ayland@ilande.co.uk>
 <fefb7b6b-29fc-42ee-b62e-059512e881e4@linaro.org>
 <3ff9df0d-6465-45a3-bb62-0db17ed9210c@ilande.co.uk>
 <d84e246a-fb43-4bb9-ad61-5ebfea4e323f@t-online.de>
 <CABgObfYsCO-fH1MZQ1=mRUJQHn9h2QBcCfytBnDhhM91iEd4sA@mail.gmail.com>
 <d2e11eb2-4a4a-4e23-b200-3995ea865052@ilande.co.uk>
In-Reply-To: <d2e11eb2-4a4a-4e23-b200-3995ea865052@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Apr 2024 07:46:14 +0200
Message-ID: <CABgObfYuAv6brH-C-jZtof-tTdMXLZP-fJz9jgQR5XsUB6F7wg@mail.gmail.com>
Subject: Re: [PATCH] target/i386/translate.c: always write 32-bits for SGDT
 and SIDT
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Richard Henderson <richard.henderson@linaro.org>, eduardo@habkost.net,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 23, 2024 at 10:42=E2=80=AFPM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> > Let's change "Despite claims to the contrary" with "Despite a
> > confusing description".
>
> Thanks for sorting this, Paolo. I suspect that KVM needs a similar patch =
as per
> https://gitlab.com/qemu-project/qemu/-/issues/2198#note_1815726425 howeve=
r the Win32s
> and OS/2 Warp 4 tests seem to work fine on KVM. Maybe it's because the SG=
DT and SIDT
> instructions run natively and don't need to be emulated for these cases?

Yes, they are almost never emulated (only in big real mode and only on
old Intel processors).

Paolo


