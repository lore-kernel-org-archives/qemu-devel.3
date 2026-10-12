Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C097CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGNx3-0000QP-1d; Mon, 12 Oct 2026 17:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNx0-0000P5-OQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNwz-0006NW-9e
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791841972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nqO+u64ko2DqHr6cEg2Hx5HDRMgfV1zle10AY70atRg=;
 b=QP6qL9I2L7qNS24c3sxKrZEE2MyF+J1i0XAvoVaUQOIzEQZ6EFo97br2QRyAltBkEobrfJ
 f5jQX3mH2bouX2ErhUqpV+wQmUkumdlICXvlbXTs4prEfjeCCq5pFAleCaBBkuJ9t5raUW
 ak4QNCkicgQ2uV4AGAlH6TH7QO9IHjQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-pBkhSiSjOTiXTm0xgdGCDA-1; Mon,
 12 Oct 2026 21:52:49 +0000
X-MC-Unique: pBkhSiSjOTiXTm0xgdGCDA-1
X-Mimecast-MFC-AGG-ID: pBkhSiSjOTiXTm0xgdGCDA_1791841966
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2417A1955DBD; Mon, 12 Oct 2026 21:52:46 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E8941956040; Mon, 12 Oct 2026 21:52:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 11/16] tests/functional: split aarch64 tuxrun into
 tcg and kvm run
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Anders Roxell <anders.roxell@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>, 
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>, 
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261012170330.1144446-12-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-12-alex.bennee@linaro.org>
Date: Tue, 13 Oct 2026 01:52:29 +0400
Message-Id: <179184194930.2190936.8012364654417559487.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=589;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4Hku+vanoRUZb/IA3EWpfYgLdiYuHTElOjM3dcYFL1Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzVafXosT6PveLogaJ2/5GnsVzkZYxziPtRhN7
 gHXsvrO1GGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1WnwAKCRDa6OEJdZac
 5Z5DEAC5LS1H06C57gV4PchTm8TGplXUy+vcGdwnQ+v5z1aLYcUz56h/Ek+xnkcrS5DvtGsxHOg
 TzWYtmTGCGjytfWeV6aODAggcV9cA9kpJKE5uTCAJRkbZ3RqpmihQlCuTP/rZl/fHWaKgUd35LU
 VO62FinlnSKBtnMJnQ0KUkanpbP4S7Ybe2ORTthDa/+/IiW5/QsSijiI82DODrZZtaLFEZpJkC3
 Vao+oQ7klAqB046Ql8noQn8Z4yXtruvDrUf6TJrSAWUbUN7glVBim6/pM+alq97sfu08OV6jyv5
 uc1swZmXnkPS8aHkQDFNzDOXFu0pljFFsXo6DiixCTb7LTxAgzIzQc76De/0n+xS8YgxwGelRzn
 jFCjeKzxlT8kiYN97+JG+nUZdkIp2PuEmi6RgpFbXQuSJqJSadzxKreG94NTade4qOiMh0bNJpi
 IqhEQbuFhG0HuK4WJZLNwuY0EuRmKIU8ygjV4AWYSlP3U1zo3RQlMnFVqnDehqHeZTY8aRRCLOO
 Ls2w1tIvMXpi76No33/SLppPfkmKg7Y0wHK08gYo4k3yUOCHaaPg5XilJW9tK+Hbt6Hx1+pnyyA
 DTKsS9pfI+jL9Ug28MfFqhlP0dU2JS/UhL9U/u4h8jmip8CFrzycwq45Zss1iowKTrmKZlzISn7
 gYO7CVdjELCFr3A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Mon, 12 Oct 2026 18:03:25 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> Add an explicit "kvm" run to the tuxrun tests. Although running on an
> aarch64 host would probably have defaulted to "kvm" anyway we want to
> exercise specific features later.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20260930164649.433573-9-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


