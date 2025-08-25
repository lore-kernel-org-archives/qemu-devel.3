Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4892CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 09:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqTys-0007L0-OI; Mon, 25 Aug 2025 05:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uqTyq-0007Js-Cm
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:59:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uqTyj-0002Lu-6a
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756115939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SqE1wYfDYojFcGZyUPFR3ZBs8YkWEU6ARG7lPiQTyD0=;
 b=VvPPMML1FaTL0DQnpHs89es6Hbi7ipK++TUY39emLV0h/PIp8ANHtxihKnnfubi+zhFpVl
 SxS4FL7TimpBNsUiZvrvID97rtxYTwODFf9X0p5W/gnz3o/BQ+4HWssi96C08UvflCYjQw
 JxgQUC9dKOEC31IcL39N/uNLmn6BMo0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-JmxZ2I8vPuq0BMBDkMmMRg-1; Mon, 25 Aug 2025 05:58:57 -0400
X-MC-Unique: JmxZ2I8vPuq0BMBDkMmMRg-1
X-Mimecast-MFC-AGG-ID: JmxZ2I8vPuq0BMBDkMmMRg_1756115936
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3c8bc2914a9so568839f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 02:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756115936; x=1756720736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SqE1wYfDYojFcGZyUPFR3ZBs8YkWEU6ARG7lPiQTyD0=;
 b=BXgetcGi1k/xR3eJ1saEBdh9DObSqQrk62vjKq8zmxlPR67Crl5/ec9xsSI7a67BRB
 CKFjABVG2frAnvXdHw9VnIYuEvO6+UQReVsL0SuTiTpP7HxcBU2AJI6uRVvpCO/njEFC
 ypAXxncgj6kAYJkQtGny7z3Efz/l6KNMPtPsbq3kPQbjncLIHL55QPiEM9LHiCBCPWaK
 7ln43ICfeUSMdTc/WDXRlS2XQ+BrFiNn4sefPbsFALAlYE+n4BAmodfapk9qYv7nQRnI
 3aiNn4NomLhu+SNOWbHodmj0OqcYFODwOAqFRh/UoDa4o9Rkz3zFYWIKuYyyitGcytz9
 Gnvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQglhhVQzGIs61odTZyLpMeU88VEzG1T6s/srYCQjGi9ulogbeviKk9P+FVv0SApcFhhfMr1EWUb4G@nongnu.org
X-Gm-Message-State: AOJu0Yxl+9aN61fjGKUi8a4ns6EMCK9LR2ihMzhan4ziBZMjy9Uiz4Ex
 jrtouAQ25wxRR1HoabzO2lJ+Zk+n/eotyn5u5cBEI55tsk4v68QABi+N4Cw4rfNQgayNLz1pde1
 SPcfb74yIzeiivJ/f2X8n00+e2xd/xgKLpodDEtUC9/oPiJYqRqwEh3bu8DzzgJIBRlbRNpsRx/
 5M2tFD86sUifVtUpeYys8V97Oeb+Bp70g=
X-Gm-Gg: ASbGncugcJ0zEjKu+eEEUONBKG+1RuEGM5BI0L830ihTFjP+vI6RWCCKWD3tGWJxkhL
 YQYE+tXXcO4WyWlS9BjFBamzLhjENz9uYlYoG3Vjtux10TP4E9MgY7AEdnKmNsHFA15biqvdwp5
 8/8vZdPGfuIOF5VyOOCTqUyaKMUhu8f2zumRiaiqFH9CZKHYyBxTzCsLfMZ8B5vEpCorMVZB8Xd
 w3N23fAt98Wsc0FmG+WUf7ToQ==
X-Received: by 2002:a05:6000:270a:b0:3c9:73f7:c835 with SMTP id
 ffacd0b85a97d-3c973f7cbf1mr1309215f8f.29.1756115935974; 
 Mon, 25 Aug 2025 02:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyEjnfXcrPXkR4cLKAf75l8KGjNaDTlC6TVVVb64b4ugTCGIolfmeV1gmzXEwiRnhDz9NLvRIpjx5alrS1Vh8=
X-Received: by 2002:a05:6000:270a:b0:3c9:73f7:c835 with SMTP id
 ffacd0b85a97d-3c973f7cbf1mr1309202f8f.29.1756115935582; Mon, 25 Aug 2025
 02:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-9-pbonzini@redhat.com>
 <aKwV49H1RE31Bue5@intel.com>
 <CAAjaMXZFus_sj4P_SNgUiWQ9xEO_rRmYvf5VVDBfz_Z_S6TXmg@mail.gmail.com>
In-Reply-To: <CAAjaMXZFus_sj4P_SNgUiWQ9xEO_rRmYvf5VVDBfz_Z_S6TXmg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 25 Aug 2025 11:58:44 +0200
X-Gm-Features: Ac12FXze9heThqmIWqLBN1Fx4OwcPWfF9d2CsBgVkfNo52fgcI_3Vm0uuvCDi40
Message-ID: <CABgObfZ4r2B0w-1XVcNG3HeZTPbSfuw4KB4uXxi2-0fYvP17wQ@mail.gmail.com>
Subject: Re: [PATCH 08/14] rust: qdev: add minimal clock bindings
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 tanishdesai37@gmail.com, 
 stefanha@redhat.com, berrange@redhat.com, mads@ynddal.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 25, 2025 at 9:33=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> > get() sounds too general for Clock obj...maybe get_period()?
>
> (Or just clock.period())

Will do period() and hz().

Paolo


