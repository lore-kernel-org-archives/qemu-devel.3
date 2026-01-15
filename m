Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DEED46623
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 20:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgUE3-0005to-CJ; Thu, 15 Jan 2026 15:45:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kelly.cullinane@oasis-open.org>)
 id 1vgTFF-0008TR-Ti
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 14:43:02 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kelly.cullinane@oasis-open.org>)
 id 1vgTFD-00077O-Sa
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 14:43:01 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4ffc5f35b54so18511031cf.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 11:42:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768506177; cv=none;
 d=google.com; s=arc-20240605;
 b=RqKUSaZccbUvX5e0AnfijaZ6ogcgI9delz8mVqAa8oq5Jn0ujlBDXJhqPCo6iOLgPx
 EAEWXNArMzi119YQIokTp0MPPwv8vyGAep8XsvNwPiD+S8EQ3LH+bwXPpEKrYjUG06lQ
 krbRQd/j9gYJHTXv5699mI3tnSYBNZ0K94gDKlxCl812kSVRWuR5CMoeXwL8X3AsusPr
 U4swPrpkk4148WQBE57cjiAFtwQOyN+FHKTzV+eKdlnoljKNKXFckE6DU+6MTwYMG3kn
 dp7XIxxFjFaOMJf6DbKHZRviO0JbWV8pxgpqu70TZbdAPg55iLHFv4EXCZW8pgcJK4nK
 ktHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=a13hVAHkh471hkmw0sE1eawaxQTTbl4c2UbgfDMrulZG6SqQizlfNf7JaDW1Arm4ei
 4JY/CGkAPYZT1nzUvip0lcUoH4JfgtlTzoTAYpfDMmPKqmR8lfAwR8LGy0euTGFjNRle
 L6LGiXCZFC+vFXWXldzoEFH0Zz7WPsw4xrUSg23Q7x1vApsixTnfDWJkViqeJZ1esTvD
 TQ4EdEA0brpIa/YYY6uODdK8dNtEuMXPMTydnR8PUJ+jdmN2IathzNPgZaYZmUqKI+DN
 NcNuTs0uwDsK5whudhYkcBDBnd8lVhbUqrqgt3VssGSPmiWkPQE49z5OPzxjNd9EcUpf
 WyUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oasis-open-org.20230601.gappssmtp.com; s=20230601; t=1768506177; x=1769110977;
 darn=nongnu.org; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
 b=mVG0hM8FeOdabHztB/ZFIfawD7ou0CWJDF4/T8lXx7yHDyKMs0w2NqAoavHTIVL3oN
 3xZw8+ezKZFmw4dNyGAc5/jMxxYKHsLSKQJCdTVqs4ltnILvTn442cAYzqm+FWtal32Y
 XpFz8dITwBt0Y/vxxHyK+7eYiASwkZkAM5dKPGtMpWZALvuswyd+Snj4YBMcx/d3ACvz
 jBnibDNwhjzqsF9/tJ+dTt83UL6z52hpxPuBllfbvTUQGR22KeJKYmrM2L3nnzLGi3aw
 jSzTykQvlNkqBaBvjB+JqipLEYohvV+bDWjws2OXDh14Mk5YTUfJrfPzKX3aVzs4HUrI
 xI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768506177; x=1769110977;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
 b=N0vmELyGeUUxZx/LR34gdKtrxTj+9UOJHq7xFMOb75CTzG+QyQa8x7/TYphBCqzwIi
 uejnPYxp1eQVn9g192sSLcFpO4hmqP4CCC9Kh6bxs5/kCX4o2oGFtbdhuCAPLGOWwHX6
 +8wKbcfkbnX6DtW+sr5n1OYcxa+Po0Qhg5+Ss00aB7qsAY1gTw3y5ISP/QoyM4/bFyW0
 RXKOf3mydbCddtzRZaIUA1V8zCZ+AKLcFzy/co25kVn+m3FE9WyFQZv54HQeSMT1Hwcm
 ON/vGmUkTgaPx3nUosZ83jk2Z3qWLNxMkZXJp1Xb24qUYp84Zkp/9oxZ8zEo7mfNrywA
 pTfA==
X-Gm-Message-State: AOJu0YzqXj8PwmpVPyro1ehyqI/78ymyJnSKg3uNnqK7ahFNfFMYQrAg
 UlNI4jG5A7FbuWE0Wi4aJK+v5vdVOhg8Cqnu3dwwn6W2/se1IbyHR2/jYlTal238Zf0/mRQG1v/
 YHPKeNAjY2OJ2VgJEDI/x+6LaXVxhr0VwoJSRnuuFb+ljxe14JoRI9X4=
X-Gm-Gg: AY/fxX7FKIcLMZ9eQ71rTT9yPbPDaDPvNbmKTziavO+4JSYHfYbUvLzzkhHk+vcoEZ/
 Z1KPB86gd0YGaTBR2v0iwQJczPd5UL6lT1ozgLHFGeJWFGL/IY0NECaVJeVnxZTP5axsIsHHdS/
 kKacdcu4CGQegihDq5CpNhN5NjV5kfVxktNfZqs/obSc0bLJ7YjoMgHMBJoFdETGH86dcfkxiAO
 GDxHWEmESrTkywLPUWUMctSFa5vs1gO9xWbb+TS+0tJRbjBN/npVjCghYDhz3RWnRHeKMt9khr0
 DaKQ85NPKbhO8dHN2LzzrJnUSgZB09P0hjIcXqdqpPKyZebNJzwyQA/t1VD7
X-Received: by 2002:a05:622a:411:b0:4f1:ccec:84b0 with SMTP id
 d75a77b69052e-502a1f82c21mr6340201cf.57.1768506177294; Thu, 15 Jan 2026
 11:42:57 -0800 (PST)
MIME-Version: 1.0
From: Kelly Cullinane <kelly.cullinane@oasis-open.org>
Date: Thu, 15 Jan 2026 14:42:20 -0500
X-Gm-Features: AZwV_Qjs08tGS2fCNaZfZKc6ZBlNPl7GFmYqfaCBM6gz6pHZBaSGEXxzjP1u8sg
Message-ID: <CAAiF601MvyNNsA77U=vdKwHr-xgQFmUp2u5izCY7Qfbs5_OfTA@mail.gmail.com>
Subject: Invitation to comment on VIRTIO v1.4 CSD01
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=kelly.cullinane@oasis-open.org; helo=mail-qt1-x832.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 15 Jan 2026 15:45:49 -0500
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

OASIS members and other interested parties,

OASIS and the VIRTIO TC are pleased to announce that VIRTIO v1.4 CSD01
is now available for public review and comment.

VIRTIO TC aims to enhance the performance of virtual devices by
standardizing key features of the VIRTIO (Virtual I/O) Device
Specification.

Virtual I/O Device (VIRTIO) Version 1.4
Committee Specification Draft 01 / Public Review Draft 01
09 December 2025

TEX: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csp=
rd01.html
(Authoritative)
HTML: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-cs=
prd01.html
PDF: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csp=
rd01.pdf

The ZIP containing the complete files of this release is found in the direc=
tory:
https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csprd01.=
zip

How to Provide Feedback
OASIS and the VIRTIO TC value your feedback. We solicit input from
developers, users and others, whether OASIS members or not, for the
sake of improving the interoperability and quality of its technical
work.

The public review is now open and ends Friday, February 13 2026 at 23:59 UT=
C.

Comments may be submitted to the project=E2=80=99s comment mailing list at
virtio-comment@lists.linux.dev. You can subscribe to the list by
sending an email to
virtio-comment+subscribe@lists.linux.dev.

All comments submitted to OASIS are subject to the OASIS Feedback
License, which ensures that the feedback you provide carries the same
obligations at least as the obligations of the TC members. In
connection with this public review, we call your attention to the
OASIS IPR Policy applicable especially to the work of this technical
committee. All members of the TC should be familiar with this
document, which may create obligations regarding the disclosure and
availability of a member's patent, copyright, trademark and license
rights that read on an approved OASIS specification.

OASIS invites any persons who know of any such claims to disclose
these if they may be essential to the implementation of the above
specification, so that notice of them may be posted to the notice page
for this TC's work.

Additional information about the specification and the VIRTIO TC can
be found at the TC=E2=80=99s public homepage.

