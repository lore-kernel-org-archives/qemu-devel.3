Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93967C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2lo-0002du-Ge; Thu, 20 Aug 2026 09:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2la-0002JV-9L
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2lY-0003av-Sb
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787232308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWFeEP63HN4AI5YBfU9OyWKSJMnm0V40fwuWQQZ3u64=;
 b=V9HgyuxwpqSeX/V+UmLBR9nufdwk7hCV4nqDygmwSfl4vfqRDDzZlgmwUvr2wjlUWwlLYG
 6eB7+C7cemvbWi3WtNyGu54rFcVEahuHid7VkwKKnz22CqmTegtpVVGRfH45L15OOnu81s
 +l8ZIdSjVn36KPI70H6c9jfRAao5T6o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-tg1NMOtiNNWgNobapOox6g-1; Thu,
 20 Aug 2026 09:25:04 -0400
X-MC-Unique: tg1NMOtiNNWgNobapOox6g-1
X-Mimecast-MFC-AGG-ID: tg1NMOtiNNWgNobapOox6g_1787232301
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5316D1801347; Thu, 20 Aug 2026 13:25:00 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3B54180049F; Thu, 20 Aug 2026 13:24:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH 11/13] target/hexagon: Constify CPUHexagonState in
 hexagon_thread_is_enabled()
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260820104730.25462-12-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-12-philmd@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 17:22:15 +0400
Message-Id: <178723213513.2730041.16593997297243047041.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=341;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DEVm86aXaBMsOiLkl2+gUrZtB9ujNUXDzajg5tLx1Ks=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhv/rJePzy2n/cZeXZ2+wmcu9t5ZneAQHcPO4/
 GsEuLTo016JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaob/6wAKCRDa6OEJdZac
 5fHpD/4i5L1LgPrbb4E+5cCt8Mei29nTspEF0t3oxVamtRzVGLNXBcWYuMyw+6srquBs4jf+QH6
 qBfE86fjLSxUe/o82EglnZhj9QUJxgLsjb35pQoAJAgMtx1JRmQQ1pRjfwsFMjNd+5qz9r6Fde7
 1Icb5ym35vDTazW2hq9AtexMTeupJi0Ju6/KGQS8r6+qQcFd+lPe+d00ALiP+z1wopovDPwF83L
 UU4U2KyrdkbIq1g5/ul6TvVPQZF3K7tRAMNeRGEZNzJnXFs/Z3knMZ1CfBwYo8VYKWCvvXMTdVl
 T5bfSsMp8ADIIc+TnXvVVMqUTYRNsqCQODoKnvvpcSz1SveIUawggH1jryqCMg1dBGVNk2KVkxk
 PmPi9lzMH1yUQJgZ+pK5tud/dlWqSBxT+rvzimLs1iCiJeWUkHTF6gYB7mpIzt0TgS0I+40UVwn
 kgPON+UHV4QUHrfnbdBDBichXv4KYQwLs3kXk79hBA74mjWeLfGtNhzmloKqI384GqzOI5vJgY5
 SIeagfWeufoPjSObxLR/W71aSRfV4toNpl8KtycrMEP/SUnF3rh4aapjG9mXu4ZPE2f1rsrfXYk
 u6tBQmU/7PPHdg1qP20QF0u2WUuKUfnXQMJQwbnO44GJADmNP4+7uFZrnrPvb3ImRhpOtz8Grps
 WPRyC8w8RZZezVw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 20 Aug 2026 12:47:27 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> Use the recently introduced env_archcpu_const() helper and
> qualify @env as being const in hexagon_thread_is_enabled().

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


