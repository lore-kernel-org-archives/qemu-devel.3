Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B41CCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI00w-0001So-Kq; Sat, 17 Oct 2026 04:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00v-0001Sc-PC
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00u-0007B4-EL
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUCTvHDVN831EEam1ufWEMN+wAHDOKWSFNjEOh8glE8=;
 b=eDDmuCFKNxD/Q7QERvtH/GGavmR//xH/vZNfFLEEbNx3RO9hcHl14YAKEaeqlFiuUw6fvR
 EFCJ6Szcp2FmLBSLhoFZ+5uthy2CDdCn/vNyPSkaZHnWL00+q0TgpAmn0RkDHfWAJRVgEi
 50+HponXVFKGlPa4wcIs7qTLBWOTeDo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-a5E2SpztO1qwniSChvAJiQ-1; Sat,
 17 Oct 2026 08:43:31 +0000
X-MC-Unique: a5E2SpztO1qwniSChvAJiQ-1
X-Mimecast-MFC-AGG-ID: a5E2SpztO1qwniSChvAJiQ_1792226610
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F059180063D; Sat, 17 Oct 2026 08:43:30 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B871F1800677; Sat, 17 Oct 2026 08:43:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 10/23] target/riscv: implement get_dump_info sysemu op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-11-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-11-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:49 +0400
Message-Id: <179222656902.1619676.8517014137987749112.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xghlcx0UJehjKpZvAwWwzn/YSG/PPU0XYnTL1WAN8iE=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGrTNQyiA+6fxVwmE6+152K36t7A3jj3ZQKiprMErCWd8//Z3
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJq0zUMAAoJENro4Ql1lpzloJwQAIwr
 1A7Emq0axot/vaIV9W0sOmz5qXSy88OtLBtCwkmHcYLQWOlTMpg3qC0bAo8sGSEnrCtIhU2UhYM
 ujjDlMw5YxYVy5ZhqvEyX3jN85vDbZeSvLDerkCSQWC+aup1ZXRuL6FzNWordkRb6g8I4z2s7h9
 xLe1XQHnJBQTXN6j6s5Ij9JOM06mBq1cdQkGYH280Z7iE2TwMny1YmLaFiGbjogC8rHDukJBnt/
 JFZT2IqKnlwyXZbfh5KryhA7kS8QnzPe4HO+d/ac0Ao6P8s/gkrL9WUvLM8Y4Fjxf72hsJqSAMD
 JiBUXKPX2hBvcumts0xtSVsGslPDKJlyx5OhIFdeudOpVJZCoTpkWRe+yCuecgwBbnuQGPjw0uj
 sjMFQOPr4KBJrsIU8ek1Jktv+Rnutqcv4xLb+0ipxGax+W6cmAWl2E/Egzopf0Edg3l0YyyC4P5
 4c0wnQfOEd/gZDJ0VKvEQ8jli9KahrLJfFcv9f/o266LUWchwyiPF5ZowvOA/0OlEM7OKswtmiI
 XjMWLfTaOYzn8KPZItslTIJZpESa9X+7WiLy3z3el4DYyxZCS0UlTYumsKbwC2qrMVjE5UafX3f
 kgWCFGr7npvv/d2t/DisCgKgZb2hpCahb1qo9otQVzrr6csHlicz01J2q+1K2nTnl9U/9oATeJY
 lWzNo
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Fri, 16 Oct 2026 11:13:57 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> For now, we keep the global cpu_get_dump_info symbol defined.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


