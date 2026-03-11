Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B181125851
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MC7-0003BO-5t; Wed, 11 Mar 2026 12:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0MBj-0002y7-CB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0MBg-0008Bz-Ex
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773245611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Ms3fJrn8QkmTGBfUHjGIungq8i2FyVgCzXBMDKS5rDXzaa32c8M52dCdQTH0nz/ee3n3CX
 sHL+ZNNcxw1ZctGipyUbhvPdXSYi2QPgIdM2/ax/FCSQ9frdPHlukKOKc8gz3cvQ/V+5q7
 GSKrlvw+O8fUYKPSRIkqZSmamHZROSE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-dPlud3UaMLK0w_e5WERrfQ-1; Wed, 11 Mar 2026 12:13:30 -0400
X-MC-Unique: dPlud3UaMLK0w_e5WERrfQ-1
X-Mimecast-MFC-AGG-ID: dPlud3UaMLK0w_e5WERrfQ_1773245609
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4853f33b7dbso82825e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773245608; x=1773850408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=I4mW0EEJT3ywfr7rm+ViicXP1YsPjna5NPXKeQcAYd++S5t2rIxGFKkIGCSLPpGMe6
 iwuGtjyWZPk++F/fWEtV/Y7GWKfwzA7H9d/jHs2MhioB1ERCfstdNQkDUD40Eo59tqus
 ayvvKF/tubwTIvGX6Tn4iLybqRKvCHUerAmgGnjPCowvoqISQ7IRI2ftBIiUQuYqk2vs
 T7AAYMyA9mmb7vr9jxkbAe8vpPPSwvcl4IWkLtE4nl7v+6eLZvRfACzAAZT/IbGfkKxU
 vdevdkz2tx3Dal5odX/4Sop3vi/uQ/A1omVHAsMm5ipmRlvjdsateM4Zr0pNS1Ys+7zV
 /ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245608; x=1773850408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=h8yEvhqbYU/s0PRCLkH+w7kxhTwnnb07s5kD1R7ZXrxxObU4H3TsOYF0ENCe1SR2fI
 qJr8Qc+RlWdRMzyIk1VfVWGCq+jF8tygFH27rYSYhsxuhTPuvtdmLJASYTNQ25iBTceJ
 7HxhqJDdWoXnFuz4JnZFMyFY8MvNpseap4FLq4V09H0UAghtFY8ew8ErzeoUsrOXARMn
 /cD4pMbhC+xOLS3FXKuH35IJY51u9JTQ7vyuezaZTMgiTVljLkmmOIiCm8v1dOwmUC3X
 dLGR/A3KALCPEbTu9T1Vx9OZzbh12yjGeoPKsDTiQL3w/tmX3N7WgPP08yPoYvrI6NsR
 /X1g==
X-Gm-Message-State: AOJu0YxAl72jg7SS3VdosZMAm+pSFaQlWHgkVbeji+5OTmplFuyoGe8I
 c4PYP8uy4XClTPoU/PuP5CnYMNofIoHWfCeYxksuuRigQpJGPO/FLrlAezRhFJTqw7QDnZP3sQE
 D7hEze/j93l/eThEg4lJ7JhMG+be68tcrunLW/UQyPgb84UW13cyYwkg8olmypHWI
X-Gm-Gg: ATEYQzw0Fu8EurHSDp7hG+EQlTRDUsBYXtlELmYsL9C13+N94vqjE6uOUPu/os4fsr9
 ySBYWyKcFgO63gN7d6WenmYLWIEKkLw8IzpTm0B2oYp+LtMtln6AEMqZoPzNmRp5JiE9acTECX8
 ZPBNQXVkWH+1vhMsuiWyCOptymwz4wjOPpteDtWTbO25xU8hUFlgHPS5gW+P6/fF1Wq4oWkwbPS
 HaTQueWSOgmI0gChy1hjDKK6yvQ3H6bXFKg20gRSInM445SK8/bKY1ruSiPeepT9mJ44eWIYPRY
 TW5cBJQRm2bo0eGAAWtVE8xhthujoh2ag0TWkgLZ/iN8Nq67rdEODpN/+3rMsEUTaLY2pFxmceK
 tHHJ6NUDfy+ncQT9i8jurqpbf2ByWVYeYl+XnGY80IahrW5fovNmObvOkwD+P+6R6xqPIKXmqIr
 uh/ySVNXcwwZv+lJOEwDkSVjxHQgs=
X-Received: by 2002:a05:600c:3115:b0:485:3dfc:569 with SMTP id
 5b1f17b1804b1-4854b0fb19bmr51021615e9.16.1773245608421; 
 Wed, 11 Mar 2026 09:13:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3115:b0:485:3dfc:569 with SMTP id
 5b1f17b1804b1-4854b0fb19bmr51021015e9.16.1773245607929; 
 Wed, 11 Mar 2026 09:13:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854a18ddedsm61846545e9.0.2026.03.11.09.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:13:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 0/3] docs: some doc updates
Date: Wed, 11 Mar 2026 17:13:19 +0100
Message-ID: <20260311161319.558220-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311102626.46546-1-mohamed@unpredictable.fr>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Queued, thanks.

Paolo


