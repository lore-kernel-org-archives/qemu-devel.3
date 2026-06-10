Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F576CD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQH9-0004jm-LP; Wed, 10 Jun 2026 17:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQGq-0004Hk-Fg
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQGm-0006ny-ML
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4iM2b/uUe5vvhsI9W3EdaSytqkD4evkjRTtpMP6ec8=;
 b=c8paRBeVqD5Tg9pCGFfAj4YQ8qzfB5mQYKfv7fcbKkzid0czL24nweYUdlXd9V3E8k9rjc
 OX0Ehgz5NL/PJgLIMNE+HZ/Wn5RltHy0v8j2wYRON0ElYgiotKvM0t/XGVxUuBXIx/egM4
 YeB7ObA5fuq0WTdEwfjRTb5Gi2Vinac=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-RkqwfHWxNsqaQsC1soTwAw-1; Wed,
 10 Jun 2026 17:15:12 -0400
X-MC-Unique: RkqwfHWxNsqaQsC1soTwAw-1
X-Mimecast-MFC-AGG-ID: RkqwfHWxNsqaQsC1soTwAw_1781126111
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B670518600E3; Wed, 10 Jun 2026 21:15:10 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 763DE180029C; Wed, 10 Jun 2026 21:15:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 15/35] monitor: use dynamic cast in
 monitor_qmp_requests_pop_any_with_lock
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260610123415.2883603-16-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-16-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600352.209622.3677633262934026439.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=294;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fD3GGrBft5F702x1HW04+Q+uFjaLGADtECAT06phtQY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOB4y+va1cUQGitEkmBscb/TYLWJfD6wf+Jt
 nMnZYnRPxmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTgQAKCRDa6OEJdZac
 5SphD/9x7knxsTW2paA5UZZnrSFQ8imWOYpEqnGYGf6DrdPZQMsU2E07+io2cqPg8owN1HgtBnE
 r44MjBbHk6KMVp0y/DgH96Yg/V14zN+G7KBqZBUGfvvsMRxCsspYs6eRp/VdiH6iPb14+aKgzEl
 K35SmJoZkd1780UEFp4ZFyafx8SNhonLOttAsACMoY70lt5ajvH/zIWdWgMYEz0UjBqd1Ind9hJ
 zHYbCfIk2tVzPC6D08UZEDf9F42MJsqCCmjsRsK08cGeyMeeLtqIS2VqQyg8IdjhQESW9USXbUZ
 olskFQhFn38GH9RTpyiFpTxL+e5ZFsmgBYgARanQ8587Tt5bgEgsm1vPo8+vq0OQkv/aGfrRwRS
 49NEGgbYrdSGRyQWkzuFyaO2+lGmKttuPLcrR/+A8J3cMB0RnHtBoQftQiMvOExGG5Z2kV9S6Kt
 GvO3Rdd2x+wWYvevizvdh1k0d5v82FdipMEOmTHVn0Y2QWB4eQZFi9gHscIYu6paPuOM/iNWQ98
 ZsVZjaNdlZmmtzQb0ic+fPaUoFD13DshD+uslaTLubxN9qGUMMXF6svjEIuGhrX5cTHKpU9rU8r
 VX1u+tet4RmGzu+R2AvSKsLXgnqwQJRyJwX/2FDsoQ+yvWZkLzAa5LNPo2nC+8VlO9AZCaf0QmA
 5cu7ouIWx046fKg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 10 Jun 2026 13:33:55 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> This eliminates a use of monitor_is_qmp() from the QMP coroutine
> dispatch path.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


