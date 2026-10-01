Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9633DCA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCDJU-0005wW-LE; Thu, 01 Oct 2026 05:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJT-0005wO-4b
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJR-0003M1-Iv
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790847767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+IdoXXawdPEIK9qZoqDlm+JGdkIOkp2MHBcFmf3W1ng=;
 b=SvdZjqzilNEwfiy0Bs/mttj3rGLrrbOak4XJXd3fHMaSTe05SuU0N4nvOgRlt9hCnuiWhk
 cqayEuIdAMIS/riijGMo5eggQw71zqaIyseTev36zchhfsgyQLI69t96lhkI2gAtIplr+p
 Ffcn842+IkJ1ELf8eYWBEquP9tyU3kw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-2Owfu8JaNESjn8ir_j6x2g-1; Thu,
 01 Oct 2026 05:42:44 -0400
X-MC-Unique: 2Owfu8JaNESjn8ir_j6x2g-1
X-Mimecast-MFC-AGG-ID: 2Owfu8JaNESjn8ir_j6x2g_1790847763
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6342A186BB0E; Thu,  1 Oct 2026 09:42:43 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98C231800348; Thu,  1 Oct 2026 09:42:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/11] qemu-option: Use g_autofree when calling
 get_opt_name_value()
From: marcandre.lureau@redhat.com
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-Reply-To: <20260930221105.2262063-2-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
 <20260930221105.2262063-2-farosas@suse.de>
Date: Thu, 01 Oct 2026 13:42:36 +0400
Message-Id: <179084775648.2086187.2347645849423779624.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=411;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9DPa/JwlLfyu6qoMIgSqBlVDo4Vp2dbRfagj0FkLG7o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvisO3jzSWj3/ATlCU39pwqVLG8J6N7rPwtNDX
 XYHENr2wgmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar4rDgAKCRDa6OEJdZac
 5VdED/0dCflFNOV3wjSp29kGn6K2QwQ2y0Dn6gl1npeAvx+AUDHq+D1Kv53C8x405OHi2kgTlaV
 05q6lkuwYzudrNn4mtQmYyroPfQeDXoabxaISJSH6cTcw9vkiZslI+3zqgdEqr5upwnOh395OXF
 zGMFNUq+x+inw7IohFmkI9vg9Un7HjwWq11qemTWhXx3gEaGz1Oip4l3qUNkroJTz2OR9HwLGgM
 5MWSeS/HQbrE7aa3c/u6YjCxziJOjYXxQAa2LmCdL8UOswx016H3Kf/2a1gXzdi9vt0N/d92Iba
 WO/XePueY3M+DzuYtajhPpIzm0m+eCB6R1pwUGQviqgWYszQKPF8imSkTDiCD6ILbP9v712pkTh
 mNIjKmaW/sIN1ZnvfS3cvfpfsn5C4KWcnPy+zm90EccgK7UZ/Xow/EFa6mUbP8lJcy/9LqPPtyo
 xUnhNzQDtVg1N4ToXWYKAycgZsxDAZlbWCukJlq6puptGrSI3P2YyOdQYxx2NSR4+Gef/mSjbQI
 uL81yCCHe8kauX0GA6vP4ueqbglKmwnewaonRkqb+MQdPJYQSFJ0/UdbI8iPBXVb5y8nloLXJlV
 AV5PavHrPiOtOAiUc1EPKt4FmH5+157144H00wEkqgZiHmMepkkJWYvW8aiurI+sCDY1muy0fm0
 pGJTP20k3fz+xZQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, 30 Sep 2026 19:10:55 -0300, Fabiano Rosas <farosas@suse.de> wrote:
> The get_opt_name_value function takes two pointer arguments that must
> be freed by the callers when not used. This is a good situation to use
> g_autofree. Steal the pointers that need to be passed forward.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


