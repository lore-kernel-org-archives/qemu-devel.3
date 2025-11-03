Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0B7CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwQO-0005iJ-JS; Mon, 03 Nov 2025 10:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFwQK-0005ho-VQ
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:24:49 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFwQG-0006VL-Ps
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:24:47 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-63e336b1ac4so6949741d50.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 07:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762183474; x=1762788274; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fqp+h13SuwJjuGvOhw4uRqLG33jo626eVxD4g99d0wM=;
 b=rusip0DgvWTrEyTtJsa9mmtcdUarA3vcfUuCIAOr9hxl1aoIxeH5yGjepgTfJc8Bua
 CdfDU7FqPIMQDsWo7/FK4HBqvcVWK/PYyW5a76mnkIzhuVTYf2m8drRLRx7Yhm/rJsSj
 Mui62gnFQYIBv5oN2fGbEsCMmK0eUoQfc1anLmicllNt3HSEa/hg8/MbuwKpC8iUSL6a
 9bzAAw4EVTWyemdRgLjB2OL9NCT+Ta01hwARanuNdDWevYjq5JDCszsTpjJADSLhJmWx
 Hk/wBz1HORhDSysz6eHfV52k1sCz0EesvrPfWQhOnDH6Th/lZaHUbO9ux130SR/aTKuO
 8Jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762183474; x=1762788274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fqp+h13SuwJjuGvOhw4uRqLG33jo626eVxD4g99d0wM=;
 b=Svq1qS0vvpsw4f4akOcUft7T/p8sbAVsBOplE0NfeAP/JDDyReOTpfrkqRcEKPOKID
 wzBPBZuPI7NHWLa/e4uAsyNm4hL/ul3hlvILJvf9hN2tDRoPYv1Xo36F2PnzxIe2RI0Z
 B1phuCk1UL5s+C9xDA3pJzHbJOnrLxgkHtYBqB2gn7qi5pjBv+QXqnqhsiUGSW6A1msb
 3q+aLk5pU9YT/GYtvJg2fTkHcu2sLMDNBv8ZOu1L5ycE3jwXmVowlsQYdo7Nixp4QpMU
 tJoW37vO6yuTrI2exEXZo8rjl/X+A6Vf1+ejB6EJxPAe4SM9QraOG5GqOtdYQ/45hFoX
 31Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOKAoPog+hICWiJKXQvmrPf0t4pg2vGhF5vgH58itOPfOjV6XbuG/OQb1f94tQIdBAS6LvmOC3O+Kg@nongnu.org
X-Gm-Message-State: AOJu0YyH8kQla2zeyEVsV9fhUFUu+3mB/i8eFXxB2ixw2qp1jV2I6Jpp
 WCcnmsUMyQsKZdivt7/lYkISEnvIcoW3FnkYzqzzBIeVVhCj52fvw3rRGvOflvVKVpItiYQ9R+z
 cKA9GnopZZid1AqvpYyxkzKaJjhDxkqUdszT+pKGUKg==
X-Gm-Gg: ASbGnctPe/GD9qSiS1KFmQXiS9Br4w1f0tDXb5uTbjPDPXcw5jKtK+Ol2CGxboRLB9G
 Xzpvt7t3JlApJr8900ZAHqvO8GadMCE0N3E+JXZ+uJV9J2rZebd/wW1ETOetvrHxSYc560arzFm
 TIydBCJ/bQOpIShRD/DCoGQkPEoWFN1qpV+qUFerUTXiJhkNdu6sRDkFmvDsrpFdJM0Pk5hf+fU
 Ulph7xGRXjVgUDIlep7Iki8wbu1YTi+JLat3JpurcGhO2B+oh8vwe3qX/Kda4DcBVReMUIX
X-Google-Smtp-Source: AGHT+IFZcknUdGuWlmrcKI32vQZZhbh9RQVt+s3/OffwepimQTH0tXai0MULB7u27ac9BqqecpCY98xnzghXtuI4mJA=
X-Received: by 2002:a05:690e:1481:b0:63f:9d66:6ead with SMTP id
 956f58d0204a3-63f9d666f8amr9495087d50.14.1762183474461; Mon, 03 Nov 2025
 07:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20250626074529.1384114-1-clg@redhat.com>
 <20250626074529.1384114-10-clg@redhat.com>
 <CAFEAcA9+EyeWE0QSUhgd7+i3din8J76jnhTuDB7i9hu3x-urOg@mail.gmail.com>
 <CAFEAcA88jVL4Qwb4MEzdcqeXDjob1NZ3-k_ZtwPCgG+9U6fkNA@mail.gmail.com>
 <aQDKmM2FFKAusenB@movementarian.org>
 <CAFEAcA-cLQTTeuwcCfYRXwv-434_mttDO0oXr_UuaOmkHX370w@mail.gmail.com>
 <aQiaoBcgnwJEYG5j@movementarian.org>
 <CAFEAcA-FSuURfXJETNYTegjLSAUzbSJiE6+s6LGJpdhM-RxjSA@mail.gmail.com>
 <aQjIOzaujC6LrW8u@movementarian.org>
In-Reply-To: <aQjIOzaujC6LrW8u@movementarian.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Nov 2025 15:24:20 +0000
X-Gm-Features: AWmQ_bkYNAZjcjHYXtk00Os3gUbiP-gjNQ9csq6PAqEXGm5CdGSFBJG1Er5te3s
Message-ID: <CAFEAcA96O===ciB7=WyoH-1TExPtK_u4rC4GOgjrDEJ3Y1BkAQ@mail.gmail.com>
Subject: Re: [PULL 09/25] vfio-user: implement message receive infrastructure
To: John Levon <levon@movementarian.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Mon, 3 Nov 2025 at 15:20, John Levon <levon@movementarian.org> wrote:
>
> On Mon, Nov 03, 2025 at 02:09:00PM +0000, Peter Maydell wrote:
>
> > > It's hard to say without the full analysis.
> >
> > If you like you can ask for an account at
> > https://scan.coverity.com/projects/qemu which will let you look
> > at the issues in the web GUI, which is a bit more detailed than
> > the email summaries.
>
> Yes please. I think it was missed when I asked for one before.

You need to request an account through their web UI. Then
the system will email me to ask me to approve it.

thanks
-- PMM

