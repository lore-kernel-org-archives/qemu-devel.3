Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3833AC61CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPHJ-0006UH-O5; Mon, 24 Aug 2026 03:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPHC-0006Tb-8O
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPH8-0006Fc-UV
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787557162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mCSSstgtNolpew9THbB3ICRuaM/WkTnqIp1ZnifbhfU=;
 b=MDBMG+A42Nlb6cfkitF+M7mCD4EAFSCOpIwSjWnFWM/fXHfsyJOczUlS1CAOu/e792XoV6
 oz6NbkMC/NztbCogSH0zGn5QJOZ4wBrWZ/0Fi6MuQw2THvOWOLLtTkqN7IgPW+H+17Po/s
 V39tk/G+h52bqvMko3aB265e2CzzRws=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-hDTuOeSVNLi9DvB8wFL3NA-1; Mon,
 24 Aug 2026 03:39:18 -0400
X-MC-Unique: hDTuOeSVNLi9DvB8wFL3NA-1
X-Mimecast-MFC-AGG-ID: hDTuOeSVNLi9DvB8wFL3NA_1787557157
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F1FE183019B; Mon, 24 Aug 2026 07:39:17 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 235B930002EA; Mon, 24 Aug 2026 07:39:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 07/12] python: allow mypy to run as the current python
 version
From: marcandre.lureau@redhat.com
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Cleber Rosa <crosa@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260824052859.880475-8-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-8-jsnow@redhat.com>
Date: Mon, 24 Aug 2026 11:38:46 +0400
Message-Id: <178755712687.3526866.14938091004279900470.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=382;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2lL7heSr9EPhJhXqCmqc1PqwUBGYUCxv45+WxlVNrTo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqi/UK1zeig5w3rBAIREHOSwz3M0HmM7q9ivpNl
 4gSlnG17EaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaov1CgAKCRDa6OEJdZac
 5aRzEACdrLiMpEmNNDiVbmN49naO/kApQxLDYa94MlmIRrYv2Mu9/Nv9XYKI4jIpK0sCxMw3p/v
 WP8+WdWwKgCcjrSZXVjoQdskxAGbae8Rno8puoRFceVxIg4Gvb+VS5MKbncLCKm7DgyHHI+g2qG
 0oAHIKO1t66Qt+iRJRFKVo1RD8/YOEJecl0YkAWlmAMKZSAhHxBAOAUX86YLDb1/fFKbtM8GqRN
 oH3NP34R/BMzTMAeg9J2Q6m8W6Og7ypTMSlXhXu37UNEDsaL0hdt5r6KWIp08R6zDlLUb6GiZDF
 GpYh450Xo9UzD3nOmES/fUfaIvslG5D6KcAWakEnw3JC2oAktwm2Fjj11b25RHOGly9Il3S5m1c
 X/YEmp8aqt8fTcAAfpFhBi8kJO/O+FEOuOuoYg1YKgGiN6FouNwMhD14EJeg7BS91JowEI2ISul
 oWvpWBL25LZxORuL8Tee6TTLbgPAFzGYtsKJWcqHvdyz9L0sltlpYFTBJW5rVTvveJ9/Hnnpti+
 002pjB3g7eFp/ScrCPQNzCyTpdKhyojASdsWJshuMLLithSCfxHWUo0OFQkuDR9SGhkDcm/eeZP
 /OA+A+Wu50nSd103l/JFNgDTu/32fsOOq9dHUX4uIWP4WWUfO0kwQIEiiXjlaa2HcHpIAL/ETjG
 N10gd/mMeV7GsNA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On Mon, 24 Aug 2026 01:28:53 -0400, John Snow <jsnow@redhat.com> wrote:
> Currently, we instruct mypy to run assuming a specific version of
> python. Lift this restriction so that under tox tests, it will always
> run assuming the current running version.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


