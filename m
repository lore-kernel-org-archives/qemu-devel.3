Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458DEC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNF3e-0006nY-Ip; Fri, 28 Jun 2024 13:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1sNF3c-0006nK-5E
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:06:44 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1sNF3Z-0006Bz-F3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:06:43 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57d203d4682so1148976a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719594397; x=1720199197; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ttTyzbIsDOSxa9swXD5YJ0WxSCwRk9jTm8GO64bsVfU=;
 b=gsJDm/tzdsSH/x6Gz02wHF5dBT9MX7iXZopzwu1fmtEHRWMHTPVdtvog71qghH6l0y
 WX2/RPy+eGI638RTeX8tj9Q+w5UIBTTf5ZH7yJJzjJrnnvwBekSGH4X+RjqorwLUxgnb
 cETFQsobmYetdmDG3uh1ylOhE7+wvAhQ8REiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719594397; x=1720199197;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ttTyzbIsDOSxa9swXD5YJ0WxSCwRk9jTm8GO64bsVfU=;
 b=eQ4HMf1UZONUPGoLqlp7BhKQSSNTD+TtH5iUsfJR4BC+ODAQydaXMJQCM/cPCYfRL0
 XgGZ0Bp27ypxuom6HL69LCYjWSx4NajPzUztRp+Ube2bEcHXGLZpAhQre5AfAIaPC90A
 MZkeVYzewxYr+z/+HX+8izCWvE3r7SJqVpfIO8OY10wFd3Hk/6S+FMozvmL8+nzZps4b
 fUcPPyXTGgMMKoEgyhuPFCReG/LcVPxIyy5YnznbMUUtZ6oPg/Zz0DNE87Jh2vzPQ/ct
 JydhhwP6wvj2OR33m9vtpKaWPHhA3B1jMxQ0n5UjzRMKVWMan2Gd3eaxzIRD12lE7Wcj
 UQwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6s6W7pzueWccUNWM5FZ2+EYO/gkEsavBNYVQw3ClrClGwGMftElXlq7rNkZBKOzlIitZQgHb5HlRGECt5GLbS8SU7XdI=
X-Gm-Message-State: AOJu0Yy/oG3JV2UoOaVNSQvFzVmPicpEVz2r49vijP5d5zz9bSrKQj+m
 R67Tm8jGgUB+BxuqAUi9Oh4h/6K12y8+akDQletb8AidTpL0i4ZNSSLu8kUJWhW2Vcwhhgn+UW6
 SSyZS
X-Google-Smtp-Source: AGHT+IHwnNRKPcNg6DneSCGsyvjd2pXwqbfT5H/VyJg2tkva+c7ZmPx0wVOVqSYyajNX6txTtbFtOQ==
X-Received: by 2002:a17:907:8dc6:b0:a6f:b715:6cd9 with SMTP id
 a640c23a62f3a-a715f9cb758mr1227795666b.56.1719594397508; 
 Fri, 28 Jun 2024 10:06:37 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com.
 [209.85.208.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab06567esm94077266b.119.2024.06.28.10.06.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 10:06:35 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-57d05e0017aso1135622a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:06:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVc9s4GZbodd7Itmc/0hnkhvlJuAGI4ZoGLkiZG/5JQwWHYH0J5ciBdmlBPdHudr8uLx0Kjp56voXzd+zXcMvU3MDZDKfM=
X-Received: by 2002:a17:907:a703:b0:a72:8c16:b1d1 with SMTP id
 a640c23a62f3a-a728c16b404mr692739966b.51.1719594394931; Fri, 28 Jun 2024
 10:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240607141809.1637137-1-ribalda@chromium.org>
 <20240607141809.1637137-2-ribalda@chromium.org>
 <20240628132542.47b5a137@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240628132542.47b5a137@imammedo.users.ipa.redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 28 Jun 2024 19:06:23 +0200
X-Gmail-Original-Message-ID: <CANiDSCv0CoR1vZJ0WXt6=84HBXRC_y2E6AAXANMLLThonCpK2w@mail.gmail.com>
Message-ID: <CANiDSCv0CoR1vZJ0WXt6=84HBXRC_y2E6AAXANMLLThonCpK2w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] tests/acpi: pc: allow DSDT acpi table changes
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 qemu-devel@nongnu.org, Andrea Righi <andrea.righi@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=ribalda@chromium.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Igor



On Fri, 28 Jun 2024 at 13:25, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Fri,  7 Jun 2024 14:17:24 +0000
> Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index dfb8523c8b..b2c2c10cbc 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1 +1,2 @@
> >  /* List of comma-separated changed AML files to ignore */
> > +"tests/data/acpi/pc/DSDT",
>
> that's no enough, a lot more tables expected blobs are affected by
> the next patch.
>

Sorry about that, I did not realise that the check was quitting after
the first different file was found.

will post a new version soon

Thanks!

>
> before posting, make sure that 'make check-qtest' passes fine
>


-- 
Ricardo Ribalda

