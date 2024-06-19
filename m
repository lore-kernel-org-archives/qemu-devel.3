Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C3DC2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 13:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJvHe-00011G-0D; Wed, 19 Jun 2024 09:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torxed@archlinux.org>)
 id 1sJp9H-0003fk-Ir
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 02:50:27 -0400
Received: from mail.archlinux.org ([2a01:4f9:c010:3052::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torxed@archlinux.org>)
 id 1sJp9F-0003bb-2g
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 02:50:27 -0400
Message-ID: <29757ffe-61c2-41d0-8b93-4d8a6af4aea9@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
 s=dkim-rsa; t=1718779821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=43I3iBYH6pTbJQFpFCjWhUH+9pNANlj864WR05vVFzE=;
 b=Lfmri32C4go61NpR7Kd9oLqZBCDmoRfnszWQAxlZVOfQpzV34WxFcyUSCAkRBe62bfe6fk
 6GodcehRy5VQ9hUv+j8cLw0RKpOGf8t+JHpNsSPFKF3vZovcUrIlEehvc703IDMaRB3f2R
 001x6mHQr6tuset9eWBwzB+Ui0n/W3IwlrmJLCaHC/w0HocnVsMVlPG12Ic2En/nq8Rwrl
 tTCPVJg6kGDWOCf9ssl9WfzkKoHPrJ/7YA0FnOsYZna5yYr5PzOjL2itkL7k1RJFlHHZNv
 +R4RBShp2Ne6P7LzDwGYz5F4e6J2cAQUUnN7PVKUSc19lyOUxlwq2xWwZZ2SbK2IdQir51
 i1tJ5DhI8FUp13AAkURquNKREoFmnZa3qGSdVQkIOo4srOtzmMUrFmg/mqYEIRYSRWeZfA
 AOQV+LnESYOv6Q7pkqkUpJ70rl0NKvrJeElLrSfAisvGIOYrAo8U8y7ifaPw0o2qPjMd65
 Q2PZtbgHu1yn0DQ4rk+tUWvwSv28dO0+EyBfeep1SSuNiGYsqKNe5tyEx7EoapfzYVT5B0
 1u9DK0GMyfYqwTckDax95hA5XnqjLChxhWFFG8hBp12f6ZRs6cZyHhj2YApzTEDLHTx+Wp
 tFbQw8PuRxf/qVVasXxhO0/UQdtzZomb1IEUVDkxl6tBsoHCxM7iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
 s=dkim-ed25519; t=1718779821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=43I3iBYH6pTbJQFpFCjWhUH+9pNANlj864WR05vVFzE=;
 b=Jt96aY25cRo5ix08hkm+Z0FDFU1uuT/Y9U37TsISpPgtepuqg5zUADj+Xt86uDiUnqj2In
 Bx2QGJZn1flbi0Cw==
Authentication-Results: mail.archlinux.org;
 auth=pass smtp.auth=torxed smtp.mailfrom=torxed@archlinux.org
Date: Wed, 19 Jun 2024 08:50:19 +0200
MIME-Version: 1.0
Content-Language: sv-SE, en-US
To: qemu-devel@nongnu.org
From: Anton Hvornum <torxed@archlinux.org>
Subject: pipewire re-connect
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a01:4f9:c010:3052::1;
 envelope-from=torxed@archlinux.org; helo=mail.archlinux.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Jun 2024 09:23:26 -0400
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

Hi.

Pipewire feature is working great, but I haven't found a way to get Qemu 
to re-connect after a user runs `systemctl --user restart pipewire` for 
instance.

Qemu will simply continue, without sound output until restarted.

//Anton


