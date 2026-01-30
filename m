Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57D0E6BF20
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 16:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlrQO-0000vI-09; Fri, 30 Jan 2026 11:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1vlrQI-0000rV-F8
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 11:32:42 -0500
Received: from mail-yx1-xb141.google.com ([2607:f8b0:4864:20::b141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1vlrQF-00037K-Qr
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 11:32:41 -0500
Received: by mail-yx1-xb141.google.com with SMTP id
 956f58d0204a3-64997a5c93bso2568464d50.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 08:32:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769790758; cv=none;
 d=google.com; s=arc-20240605;
 b=fJ179itnrgl9XLBmd4Uvge0eWWL4fCEBL1uhR2438KveDn7bdj74cY+hyfRZzmxz2u
 UAR1qaZ3XIqzzaqqrvkyztoThWEpqqNHLBLgG3Uy2aGLDOkZFyfEXppvjbL3MR2Y/t1A
 GoQgkOZGKg+r3tmIMf2FD+I1RCl+x48UvjAGgasGrL04el7dK6RQ6VmRoB7StGm98+r2
 GNXror1fV4OXHnzZskSUIURHc477V7sSWGO1I917kpu/wKI9u62NFt07s1f3JNxnsJ0m
 axiahivDoF1adKEU82uBXg3Rdknapl/WC1JQcuVnQcc+TPDdUH/ZmcVDXsGpKW4F2FWQ
 IqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ibP/kmHcueSVH84qlwvIzotCmdpzyPBb0fuLvkjQ2qs=;
 fh=UZYLJHTUIoslW2kTQ1Vod6LVgXuRv4joMPEhgPIUkCE=;
 b=Dv6FGrobc30ujjZrEE66eHuM/LBG2lBSLp/H8Ar8iSsJaVQniZ+w36wSsEhJchSCsE
 0VB7RXHxO7mEc3f5PzvokMVOIP9ncBUlWHVf/sUGDtpo1p3B9vcnXWML7anYzgsT2MK6
 V51lC/tRpFqROC6l5Aq3y+jN5ZJRjUHQoDYUFbtvTcegID1kTuA/dmCtie1ih7zaPZ8R
 GodGXTaGVIu3+h4fbfuuaHDwCfhWQsn39vbsI8HxFoic5uGXZwNfTRtaRxC0v8WWBIiz
 yZMwhy+eMojNrYe5GXEGw5ptJ55fv43sTXar0jysJA4nQ0aaJRXb31Zd+YU5TGbbR/GQ
 h3NQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769790758; x=1770395558; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibP/kmHcueSVH84qlwvIzotCmdpzyPBb0fuLvkjQ2qs=;
 b=Ygx1Dl1Y/9jlkQY3N0l3CNUsnbgJk/Aty4NP6r93gI0Ud2rQfBqT1KpUUlScuHLUFt
 2pYmDgEWJULLxNIpoTNTr8FHvlIVXMO0FWG6eUgm916SeK4BA0w0ZxiS8Xi910WJbJin
 ZX2FBTp2X6NSKYUHtCa+GIdLhP1CgmXPm+As+/aSkXmivCCcoxAkNtmKhQ0BsxC/CvSZ
 sQOyJL6J2fCFWMOS11yBXJfyk5TH8udWkc/rWp7Yyn+FENYmkKH61YDFpSHTY9KWWbIP
 3ZUERxq8XsY7IsgOtwuPDZQm5s1W3KbAWjsI2KyDB1E/wWoN4uO321I8/fuOzYZ32JzP
 JWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769790758; x=1770395558;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ibP/kmHcueSVH84qlwvIzotCmdpzyPBb0fuLvkjQ2qs=;
 b=P2BEEsK19sloOxDnTQnkCIfLtCX7MMS+SZMIB7T0UciCqgsC++WwATaEazCupGDwz1
 I4aiVcDASzfHOX4uy1pdsIVmPCxtH8aO1ySJ4vYFN5B70mSXPeCrIPSUC/8UhG/C2w+5
 fW/HbVUUa2Z97x8Ncr6/Uw3IzaNrocvDaDZDqlYsMnwHzn5GtC+KMqrHxroPz9vZQAso
 8WFvJkJu/FwtZYvBrLXZlqhRtYsXeiALolyWOzN78I4Oip8fIMqOaiJlroaIFxWQwMHH
 /beehQz01/9PQzdPRlHu4sSY+b2JeLWZl/mimMGSYKki9WoZ9dBWpIRZ9SK/VlAKz5lR
 Z0iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW34/WRkm9FDyk93NVC7xsh/kv3V3Y7jM+J6EFCIH/wLP4CPMJL/6HVUXGjVEG1kxsX/yPhnYw4fWK7@nongnu.org
X-Gm-Message-State: AOJu0YwAvhlTEmkpGrdNvDvpPiK94KutpHMLba0l19Xn141jSmLaud0Q
 s5+el3IJPDBYAGauaN35iU1pfCaA1GtOdlX8YjaKdC6YmaWwofmSAo/G1Np/DVZ/oQv5GibjlIh
 IO9/FMZOwZYU4PJsR3EIN8R+/ZrEOP2s=
X-Gm-Gg: AZuq6aJiQAK4F3NWIcMz69gicmGys5Y7R76Nbjy5pz4JpSqybnTM5dZqTc3gXGrh/d3
 JhDNI+ysN5OISzThHq8zMB2HH3xisk3gICBvE0eG/7a0G611Fj5ii3XDwqJKGPU6QYJAE4qJIi8
 CpZNS0eaSBsveIl5D7rIskoqmuAxYCp5CJElgptYUCJQYva6P5coWIZI0kZbDVHcqYrFiext1Zk
 MQRCic/MQ6O/IWck88+WTVWqPkNAIGpwVX3IJGtSQBj1Sj8HZ8pvVlK9dfv8hQ5LJgvCbk=
X-Received: by 2002:a05:690c:2909:b0:794:7184:a60d with SMTP id
 00721157ae682-7949dfa9030mr24922427b3.38.1769790758006; Fri, 30 Jan 2026
 08:32:38 -0800 (PST)
MIME-Version: 1.0
References: <CAHhgW4UH=_65pZJEACBXh7J0XN1SH1HFS_e_FCN8Zm2sKa1sww@mail.gmail.com>
 <CAHhgW4X-R-Pm1ZV20UuBPbCtnSmp5r1HkwMjWMZ7KuVX0Cp63w@mail.gmail.com>
 <e0b9fcf2-d4f2-40ae-90f4-221268364501@linaro.org>
 <CAFEAcA-QAuiNH1RdkqsxiqKSungGfbPGgi+eAESyd5fU7AyFJQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-QAuiNH1RdkqsxiqKSungGfbPGgi+eAESyd5fU7AyFJQ@mail.gmail.com>
From: Yodel Eldar <yodel.eldar@gmail.com>
Date: Fri, 30 Jan 2026 10:32:27 -0600
X-Gm-Features: AZwV_QivfBKFKfAQS-2gFn4nwyZXyJ0H9RP6tb3XlCJuIK79DCNoAHFSiPWihSE
Message-ID: <CAHhgW4Uop7MgGAytSyM_GFYYnzSyGzTBGpswnTmSHW5Mwmpx7w@mail.gmail.com>
Subject: Re: Wiki Account Request
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b141;
 envelope-from=yodel.eldar@gmail.com; helo=mail-yx1-xb141.google.com
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

On Fri, Jan 30, 2026 at 10:23=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Fri, 30 Jan 2026 at 16:12, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
> >
> > Hi Yodel,
> >
> > On 1/30/26 3:03 AM, Yodel Eldar wrote:
> > > On Thu, Jan 22, 2026 at 1:30=E2=80=AFAM Yodel Eldar <yodel.eldar@gmai=
l.com> wrote:
> > >>
> > >> Hi,
> > >>
> > >> Can an existing wiki user please create an account for me?
> > >>
> > >> username: yodel
> > >>
> > >> Thanks,
> > >> Yodel
> > >
> > > Ping?
> > >
> >
> > you might have better chances asking directly to one of the maintainer
> > with who you contributed previously, and that knows and trusts you.

Hi, Pierrick,
Thanks for bringing this up, so that it caught Peter's eye.

>
> I think this just dropped through the cracks -- our wiki's
> "somebody needs to create an account for you" rule is not intended to
> require a high trust burden; it's only there to distinguish
> real humans from spam bots, who were previously overwhelming it.
>
> I've created an account for Yodel.
>
> -- PMM

Hi, Peter,
Thanks for creating the account on my behalf. I've changed the password.

Yodel

