Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD250C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYd0P-00086U-Pp; Mon, 29 Jul 2024 22:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYd0N-000842-UX
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:54:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYd0L-0005ck-Ug
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722308064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AYYbtEJSznN0kMOTZDsE/z3W01PWc60CVmaxsTqLfd4=;
 b=MIXGfezIrRT4GS0VeQQ1+CtNubB2pSJ+Kgb177lKfKf0mng0LDBbuWLsxE3OMOs7PVM0I9
 IsVznefma4XLxZ6Rzv7R/dyEbfCdGh1hTiHSjbudHctPR/8T6nXbeJkifw1EHdWiJCdTKp
 BmL2+XMy/wcVSNRZ4GOTXNjGRFW+QSg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-VlYmyFXcOG2ftDAvIupILw-1; Mon, 29 Jul 2024 22:54:20 -0400
X-MC-Unique: VlYmyFXcOG2ftDAvIupILw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-70d24aead3eso3589952b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722308059; x=1722912859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AYYbtEJSznN0kMOTZDsE/z3W01PWc60CVmaxsTqLfd4=;
 b=KwqKXYRSS3bJutCH746aRYutD6bLa8XoqvNJ33qMLG/4svOHfBFv3nU3sW4WVMX25t
 HENxh0C0CMUD8ymeon2yLFrALs+Lteo5f7NVqd49K4/BtDueFVuBNnzSJIy5mGwNdCv6
 +5+eVp4vdVVctl0kxQi0pIz27PyYKQ9ROVlmnPXhMRG+AS5iPDe5fhy7YqxJu7e5tubK
 OOTT0nwXU769yRs+ZRfvVdphbjrygrlh2HklYaA+joRsN8w9enYHrDILhfYhGSVmU6rT
 SeXWc3oajNwossAWQZd2aC1Uni7oj4o8ObhbcdRA0u+bmSfkyU9O/S48fTd1Q4vOnRnU
 hVGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL2RUirC8CCQgV/4IwhwmnDgo2O8Fdn6Z8+3ct+SRjOSPnwoirVtTA7Js+KqxUZho3CPVL2ggxD1qQA8ENTZOJj9Sc1aI=
X-Gm-Message-State: AOJu0Yw2ZoYzepOqqJeRR0fGMvk/U5FiuF33ZPW/5Xi2aSMS7+oOc1z+
 VycrRafaVhvj9GncVOKbwadFgrqEEb1DJ//NN44c2Ef0eByVHEq9vHvRmUXGE7HGmjfkAdfC7an
 vs+lE1rpsrP4p7LT97tlo2hp9JWQTb/H32I9blG9C5eu4ppbiOw1LoUbyObUFJTf2yDCzHBI+rp
 fHtCxa3Rlcq2vrx1JMkj232bdRSII=
X-Received: by 2002:a05:6a20:9190:b0:1c4:819f:8e0c with SMTP id
 adf61e73a8af0-1c4a117948emr8629965637.6.1722308059135; 
 Mon, 29 Jul 2024 19:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxXVIvtXgZQaMgDtJTwZSUq5Qbj4igFiyhU6Ik5ArQAhvGKnTdyAqTRGAJOVDqIsHtwz+pbgP966ipOsttHmQ=
X-Received: by 2002:a05:6a20:9190:b0:1c4:819f:8e0c with SMTP id
 adf61e73a8af0-1c4a117948emr8629949637.6.1722308058680; Mon, 29 Jul 2024
 19:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240708092630.2596945-1-zhao1.liu@intel.com>
 <ZpdlQDIjGp4wR8aR@intel.com>
In-Reply-To: <ZpdlQDIjGp4wR8aR@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jul 2024 10:54:07 +0800
Message-ID: <CACGkMEsGyKb932T_AJ63sWFObYSJRvghTYywvbDT0BpVV-c9Vw@mail.gmail.com>
Subject: Re: [PATCH] doc/net/l2tpv3: Update boolean fields' description to
 avoid short-form use
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, Jul 17, 2024 at 2:15=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> Hi Jason,
>
> Just a kind ping. Does this update satisfy you?
> Since the original example generates the warning.
>
> Thanks,
> Zhao

Queued.

Thanks


