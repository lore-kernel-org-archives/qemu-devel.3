Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520CFCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHMvB-0002oU-Oa; Thu, 15 Oct 2026 10:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1xHMv8-0002np-8u; Thu, 15 Oct 2026 10:59:02 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1xHMv6-0000Nc-OX; Thu, 15 Oct 2026 10:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=j6UC/Tb+dw7Q59X9hbBNIp9c9hRA+7GZI5qVE7e0Y0o=; b=ctncy/KqUeGbxO8sCNeXdA6CKb
 H2/o37NE1DYh3NJ3joRq14VdLWuAnQCEL5I3ItJvvq3dIpjQYI2zQhVSOElgRP4z3efebL+9+jSZn
 eDN6cZcxKBqzKUiB4WGIzYLLABfTlm9ZwAbOtPc66ezDGGfbUMVB0D7pqo686Pa8ANWy39q7Hvy2e
 BCcoed/VA9ufc6g2viyzezyOAbDmmRIew64hmANlS4F+pFLATriRTbta/zYEALYTjmt0xQpTNc/z3
 ZdI27QxBHn4vv/BS9j+jsvoM24mdE77vKSp+j7AKzhmDrmO6wlKMaAPF/7M8tdao+Kj2H1mj9uwaE
 BD1vD4dtA6YDqV0L6IefWLryGPssEq3XKm4qzWwUrQ4Vxtqjgx7gt3Pa4TosuDcDTKdes9aI6jFfn
 RhTNMvyuer33RZxh1uxbIKpdCvXdXO+Pg8dpiju4cumnX2yf1zgfjNWjC5a/SUF7V8qZZzNrUtSv+
 jCDMEcUn90G3mGqq0nxyWh2m5Xi7Ry1RLKc1w/fpp4w9pf2zwDOuY+ZgluosT3l0Hjx5lb+zkmzK7
 DN1Qbc2xeYz9gqEva8Q4dQ4xHDWZe+3e8zIY+8hFxwOIAumK2XIBUj+RJBs0WP9F4WbuRKpZZtRMf
 AewqdzQ5hAlh9mtCyABHo+PdTMr74vhnhN7lGvEJs=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 0/9] 9pfs: add race test suite + fix 9p2000.u dir
 stream race
Date: Thu, 15 Oct 2026 16:58:55 +0200
Message-ID: <2852711.mvXUDI8C0e@weasel>
In-Reply-To: <cover.1791368962.git.qemu_oss@crudebyte.com>
References: <cover.1791368962.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Wednesday, 7 October 2026 12:29:22 CEST Christian Schoenebeck wrote:
> This series adds a race test suite for 9p and fixes a race on legacy
> 9p2000(.u)'s Tread request on directories, which was uncovered by this
> new test suite.

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



