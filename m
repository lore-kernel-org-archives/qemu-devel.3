Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4876C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 08:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE2r3-0001TF-Gu; Mon, 03 Jun 2024 04:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE2r0-0001SG-EH
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 04:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE2qy-0005qR-5U
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 04:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717402538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=NX07tEATqImdeWZI+UoxQU2h/4V6FGrpCi7+91IvSrIoHbdMG/iZBx05EigszT9HfR+tSd
 dwwbpvGG0IF8Mm//AOFnp8uSCJT4gPyhqwB1rfgZ4niCkS7XqhzC+8rIAetJW46Dy8LdV9
 t2rZ2TrFEYd1s/MBaULbd4I99+4z61c=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-lZJG25EiOqiyvrVlg2F3nQ-1; Mon, 03 Jun 2024 04:15:36 -0400
X-MC-Unique: lZJG25EiOqiyvrVlg2F3nQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52b88c558a5so2435335e87.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 01:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717402535; x=1718007335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=UB/IaN25R1lgofoM133bbRA4LWAfDI0P4QHKXP3Td0BIXUJa8HLwVvpdMBdbLsgn0j
 gQIHDURgqu7/gslEjtRA20W+8i41ztd2r72NMSXKXPQ6PBA3RJn34EmelK89lkA38OPy
 18FHf0pINa3m/ZsVtJGXT6n8n9YhsltPAkP/7KsZWyRhqTBqghDy9xQV9tez37NlEt4c
 O73FTEBLFbhKk/ix7UJ8u1k6B/hsfyxRa1wn2lzZ3cSbJgkW6OQ8t+UIrZc0SezCTf5H
 f4Q8SDTnjzDxVRW5hrTtbIilaIxGWcs/TWIgCtAGgESDrP8RUsj5xD9bhrKuwZH/diyg
 MkMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj03sHIKoU2sGMNDLZl1TTb2DXAzzTW6afd1FJYzuHtrLmOn+hetnmy7300igo2mLsWhu+phJi9w1OERWSYp50cjnSqaQ=
X-Gm-Message-State: AOJu0Yy5xRuM/2aSiVRj2yG2AiaRfPBXZpwSixGusG0bjS2bT2ILrNFV
 yqgp+3AgNmL324So+ww7TzEHNRVo95eHZKrI3lgyn7+tBmJepOUHbTOZ3GOIag4b5/3p4Qyo0hb
 kHJcTnpxljZxBQBrU5EvZsXEpSuVx4hYkMm5t0fV7kt4s5QL/i4ED
X-Received: by 2002:a05:6512:4803:b0:52a:f0e7:65ae with SMTP id
 2adb3069b0e04-52b895a37bcmr6262729e87.46.1717402534832; 
 Mon, 03 Jun 2024 01:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY6aoXIaPejXvdOSHzS21CqjGpup9h4qZ2kz8pao8R5nOt07U2sPdpF49JIpI2SGuDgN/gbQ==
X-Received: by 2002:a05:6512:4803:b0:52a:f0e7:65ae with SMTP id
 2adb3069b0e04-52b895a37bcmr6262717e87.46.1717402534383; 
 Mon, 03 Jun 2024 01:15:34 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68fbebec36sm177286066b.162.2024.06.03.01.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 01:15:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Xinyu Li <lixinyu20s@ict.ac.cn>
Subject: Re: [PATCH] target/i386/tcg: Fix RDPID feature check
Date: Mon,  3 Jun 2024 10:15:29 +0200
Message-ID: <20240603081529.598574-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603080723.1256662-1-zhao1.liu@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Queued, thanks.

Paolo


