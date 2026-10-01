Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D58CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCDKB-00061d-Gd; Thu, 01 Oct 2026 05:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJw-00060T-OT
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJv-0003OA-G8
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790847798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JFzdWOoWBdv8+6z8fnW3aCVMunTwmoZv+gxjzb+8zfQ=;
 b=Iknu9+ajmnkYHWjxNLY8ZLu7dy0zfkHu+Q0AigXQ52J1CYKn/muFnvNtPhJRjlaI+FQZZJ
 UvMsxJR7cEqRzqj0Qk4MD5v/CzQvm5vfs2ofXQGeMPKbpjGZ5OuHlqynh9MUal5hX5nC8L
 EFSEdwHtsi/6AoTV1bIPKWEVCxzBxw4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-R3uao4WWOH6oXiNaLQv9eA-1; Thu,
 01 Oct 2026 05:43:15 -0400
X-MC-Unique: R3uao4WWOH6oXiNaLQv9eA-1
X-Mimecast-MFC-AGG-ID: R3uao4WWOH6oXiNaLQv9eA_1790847794
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B805195D035; Thu,  1 Oct 2026 09:43:14 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D28DF214; Thu,  1 Oct 2026 09:43:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 10/11] qemu-option: Check for NULL list at
 qemu_opts_parse()
From: marcandre.lureau@redhat.com
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-Reply-To: <20260930221105.2262063-11-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
 <20260930221105.2262063-11-farosas@suse.de>
Date: Thu, 01 Oct 2026 13:42:36 +0400
Message-Id: <179084775659.2086187.17867814539969993986.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=310;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sS8Mj7tm39smzAt9Qr4+8MNYeiPgAG9hpaH7o7ATly0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvisP4UqCGnwR2tNRU3zPZhLssIcrPU43mZ0aY
 AwDgKP6U6+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar4rDwAKCRDa6OEJdZac
 5R4HEACNu9Ce4akNdBksTK6mM86vDsfYW6v20XRBEkgBPGLrgGUNty5rsGGCPogWzP6BIOTGHs8
 IPl3oIOj6d9XcpFP9KEx0unJKqwVvje+do+0HNWO0dDarCY3F3Jghy9mMhE7f1Oy4gIWFCIWvga
 EHmJxQA2noUH/lQug/ZVAPFnkNUyZr/qQysfY2vaimFQgppDuJeghL0l7huTOUnvs/amDwK/eTz
 /8j3hN2gTSdxELCpedTXge6VkwmoOhJhvHdevkN9RqNq7dzqPHcWsbEC47GvXfIKrL5hvgJi0n7
 bbtVmVPYfdc1QDrY0uqWPRpRV79JT2C7wAhM1uY2wuqzS9gIiSuiUtYzf7VFFI2HaUC1hf4y+T1
 PofDBDHd6OESRpLW/eAWtGRM8/HYBiaLuthas5rrG5RQUYAIn/wIgEKRBKWZzzYeu1cI4L8I/4V
 h0gOqIKGtHfqwo0ll3BrHnJ4bbIkgOnmC56by8zx95eXO7UNDyrHHzprRgl2VFN3lqJl9h2Qssg
 0arhRZ06rIVtkb9YId+3my6GxKABNTbWo0AL/FyNHxDVbCCf0HFaehUCK1rexZjgHy13phco6DA
 zSzYnXn00YX1RftDQdWAJ52Vj0SdNGAdx7kQkz+FrhO/DHOzX+HSiExQNjsRFECqN7zTe6g3MuS
 Ud0IELw40xWlttA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

On Wed, 30 Sep 2026 19:11:04 -0300, Fabiano Rosas <farosas@suse.de> wrote:
> Now that qemu_opts_parse_noisily() is protected against NULL list, do
> the same for the non noisy version.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


