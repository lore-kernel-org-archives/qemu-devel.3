Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C386C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 07:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF7h8-00023u-Oh; Thu, 06 Jun 2024 03:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF7h7-00022n-7E
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF7h2-0008EM-Pn
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717659471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=al4WRED1uWzultly/DWljhb6NkEd0njd5kdkzHEOO2FBseyRkIwziVxSLHalPpzvGhdDsD
 NrcKarG6+m1Pr7mxB2zTC1pMmYPHAxYwrZDpMDlYsOTiN47DDWjKNukDQ8Y6P3p5zOKXiW
 tkcWzzcd4pphaSTGxLvuZ0Od/0+oABE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-YbFlTqokMKm27aYj9si-ag-1; Thu, 06 Jun 2024 03:37:46 -0400
X-MC-Unique: YbFlTqokMKm27aYj9si-ag-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57a5af3e160so286682a12.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 00:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717659465; x=1718264265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=PxIGxWcHAQM2C6yIbSmluDJt5zoMBb5lrxrvPzl1rQCnqpgHd/HsVMFgmqj8ObzlE6
 9a6qpw/CxkUu+btpWeCGpePFQvmS8dpIEQ9iik3vmdd+XAi0nu0OGyxOUJKMP25eXPHw
 jsEgKkj8+GHtIB7F753oamUHm4RJuTW9scrJdjm3VBpVOECvrUEl1oNAGtinq/gaeXYq
 Gyq+xI6FjJTSEX/0dmHP5pRyV6u6RMCkYAYfoIz0/oM4AmkXQ07ZQvTFIzPu5nWCApzR
 axUyDCeOJ+WJlEUsKtoBkZ9cR4QH4VO+JWGqmNP/8aCff5S65/QqhISVIEcHdb2CAOdh
 G+1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBGqscHiJXsfmVcKaqBkuwPsuE+L2OUXYbYwkgEj/6pysuJZOyEUwlNWXGfcwc/tSaMvz12PwwrCJRyMlQ2lveceXB8A0=
X-Gm-Message-State: AOJu0YxzwiOIJnuLpOuBnMRMOvV1T/ZiLAyh5GlEoWvJ4WI/IJQyxBxp
 SGRmMxRuiKvWWsZ+CkTwjHdNQSengf9s0jsbdmOB87ozPKH0S0+mnvqamJ2Wer29tvGRPK4Uqdf
 6ZA/1pf7v0fGog7K5xcHeL8vYihamYUzJ3NHWNdVrp72lsCrVjwpN
X-Received: by 2002:a50:d5d8:0:b0:574:f26f:cb63 with SMTP id
 4fb4d7f45d1cf-57a8b7c601dmr3228229a12.27.1717659465286; 
 Thu, 06 Jun 2024 00:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP5LVVivAuOqZ9Yh2Ah87UlO712bGOhYQng6T9gb7Izd9sFOK99T89KGLQwenqN2la4RgWrg==
X-Received: by 2002:a50:d5d8:0:b0:574:f26f:cb63 with SMTP id
 4fb4d7f45d1cf-57a8b7c601dmr3228216a12.27.1717659464795; 
 Thu, 06 Jun 2024 00:37:44 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae1412a0sm619712a12.56.2024.06.06.00.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 00:37:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] scsi-disk: Don't silently truncate serial number
Date: Thu,  6 Jun 2024 09:37:41 +0200
Message-ID: <20240606073741.2454477-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604161755.63448-1-kwolf@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


