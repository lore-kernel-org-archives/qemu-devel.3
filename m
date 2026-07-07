Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD79EC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgxuy-0006Kw-7G; Tue, 07 Jul 2026 01:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wgxuw-0006Kd-7m
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:00:22 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wgxuu-0002Tw-Mi
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:00:21 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-697564cb69eso7460251a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783400418; cv=none;
 d=google.com; s=arc-20260327;
 b=ev7tAG7LmKC23UzqsP2LdHpGGEBXlvFvHyZhCvd3x1+7vvkihscfFSYEnKDDFksFej
 YSAJTP+U04En94XQb0WneqX+mV4EX6Yn02H0Sr+OlVyRu3Bum/l8068nQCk85PSczaNW
 aJ+EKY26AMryGB3J5Vao5gnEe2uWxHKxNekOWqoOl35kElPIZLING30DFwqmHlqhKk57
 yw02mH0FB340Xjn4BAIv8GwmiMLyySi/z7IrpDqo6QBdEckUy81yu0Rl6kKN8SFP4TqL
 ndWlq5/CqcTAkdrIPAUa0io2Sq8WN+Ds6lp3HBfT26SGdjNIDAZT35vRB73B1nUu+Ky0
 EFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=yLHlFGoErNcgMgUKNlb397L63PkPE9Zg0Z3xHeWPRUQ=;
 fh=OxaQKzCgn6hyn0RCh2n2TYHljlQPbG7ri9jbfVYTE3I=;
 b=iCxlggZsMnzxiPGFsJrNTeyTvcL3bazG/eOqQDWooV4cKBf53KhvUvFFIQTKJ8Qbak
 TH3OlrJo8BbQ9wx5li2hwjzdIZEXU5rhd4GzChxgT4U9d5WneTBoUtkbc9U0NFsimwxr
 WWoLrWOdaLQxf0TLaaRxZnpNrJQTESlpGm4rY7rug/vuQeJxOVQUEDIysZYsJ9pKq72v
 yJSzH5KlrJHXSOLyuAGrrBEEbjVZz68HfT1W7G/4o7jx8llnJ70//MhPYFdsPo90T6c/
 /UYcWPWPSYZP2yRjouDx9sShTY0rdsumQPkJOoxC810ppbj3mqAnLRRehfVMJasvFRL5
 aqtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783400418; x=1784005218; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yLHlFGoErNcgMgUKNlb397L63PkPE9Zg0Z3xHeWPRUQ=;
 b=Vxg1Mh1VKi/YdqoVKpk6NZesfDYhHJhYIM4VaIC0eplOgrsgqm9i2P/A86FB3acszo
 sdOqgjOLbkKwJGVitIQ7dAFCxaRB1Kyy5zfni11Z1Mq6Q09BWdxuZIhvSHxTHMLJV38r
 Bk3NxjBv2C2/Km0PyWaNIhL1pDYX/BTda1eDbgK8k4Xyt3IezoDdMhhzRkiga2UlItIB
 bW0o809n1wZNGii/La4R/GXZMAQwr2ewNNJyQuJO0+/r3x9/6FbhZJfsJEaWto1P6nDy
 xrBWj/Zn0bvS8eBThDcu0naZSSAlQ6mJ5hXDFR3pxA/WubdmWZPRar3mpBJfF7Po5tIf
 UcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783400418; x=1784005218;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yLHlFGoErNcgMgUKNlb397L63PkPE9Zg0Z3xHeWPRUQ=;
 b=i6Z2gcWMXeOC7Qyynw403SJCwv08Kq4JbvMNsIxru2Ssp7kVhf5/gPswKNbcKvswbm
 7HRA0hdMzRFl+jo2ThXCkANOv02viJduHJORQ2/0ndEixggnYku4KjgBTyo1fgp1wQFD
 S3Vg1ceYdn3x28nkF5xicf/W5UsZDRoBiSicV+CzKjieVTXNOmk9Xa0sLJEP/+xLi3CR
 HqWbZiwwjobhIdJ8VM4YfPA6O+SwHyxIwbD2jLKdvDDLdOJoEQlx5XWGKo1aFz8dsi7Z
 kDhtqwwFjOKMEIa6bOB6b0KWJVhvbD7j1BMCQ2AbH62Ttm5+VNaHr9IdOb6Nr+2nWGYM
 xNYQ==
X-Gm-Message-State: AOJu0Yy8nVz5PcVRi2VGne4ED1u1qu7ZeUzazHRW5NE1i2sab+GXacmP
 oa68Xw6dMYRv18g8b18AmtBcTIgBLZRMLlfCwCTp5/CsXSLHtvg7W9G7g2u1pFSFAKi78bac2o1
 oBcL4sUpMX80peaHEGmcbJVHiXa0gnADuE0ak6dtfBw==
X-Gm-Gg: AfdE7cls0VFaQdQeW7a3K6yYnKQSQBS88VCl38Gtp6WhmT8Ckkmi0WWoHmVaGKC0myq
 jdVMQ1tJ9NIrEeM9t11nmPq3hUqBGudjIwafAWIBMVZAm/CgluNsLz1to5S4F1aMhIT84AEBEk2
 b8d75vteOX0+Mz4xZSDKHnkwLopaKM5IGAwZmsFVndKNp/bV4GPnsof1RGeaxjrsOF1A6b/mJIB
 DLjSWPG4xkpr88AmJBSJqahrHHnKgaiu71izf1CyAAemjExDbvAhZMJxB8+fMJVc6edGJ7BvFvJ
 PSV/RtgRGpI33wxRCidcYj7xwrDrWgs=
X-Received: by 2002:aa7:cacd:0:b0:698:5610:76e5 with SMTP id
 4fb4d7f45d1cf-69a856a7cb2mr1429946a12.6.1783400417255; Mon, 06 Jul 2026
 22:00:17 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 7 Jul 2026 07:00:03 +0200
X-Gm-Features: AVVi8CeFUEkATTQVdHYjdJr0BK99Ed_ebJWkO3Yi4WvnUhk6QT700mCb8UsxgIU
Message-ID: <CAJSP0QVtbGat5exKTj675JaFOvYfyazO=_JJFcXd6SjMsT_HNA@mail.gmail.com>
Subject: QEMU 11.1 soft freeze (July 7th 2026)
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,
Today (July 7th 2026) is the QEMU 11.1 soft freeze:

Only bug fixes after this point. All feature changes must be already
in a sub maintainer tree and all pull requests from submaintainers
must have been sent to the list by this date.

More about soft-freeze: https://wiki.qemu.org/Planning/SoftFeatureFreeze

Next Tuesday is the QEMU 11.1 hard freeze when -rc0 will be tagged.

QEMU 11.1 release schedule: https://wiki.qemu.org/Planning/11.1

Stefan

