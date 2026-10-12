Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2082FCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGNwz-0000Ns-6C; Mon, 12 Oct 2026 17:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNwx-0000NU-Gb
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNwv-0006MV-EJ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791841968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RxQB1sM7af+oFptqOhZchGtszmFNNtnttK9TRJLWLW0=;
 b=T5ruANjI55R/Swx4iG02EgLnuy9jRgd5ugx4HwqzNsm83frGux/7cRevrahHYNUynB9t9s
 Lo5Gg4bDW2ZYs0Sgs+hbRcV42uvXr4WH2NXSDFAD5tGh0ki+kYw3w1S5IW5KooRUYAChFg
 Q1gprlyabVylZH1EeDiTV1Kzzc52uLQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-NZUiTZTfOwme4zqucp-TMQ-1; Mon,
 12 Oct 2026 21:52:42 +0000
X-MC-Unique: NZUiTZTfOwme4zqucp-TMQ-1
X-Mimecast-MFC-AGG-ID: NZUiTZTfOwme4zqucp-TMQ_1791841959
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACAB5180A9FE; Mon, 12 Oct 2026 21:52:37 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CEE5472; Mon, 12 Oct 2026 21:52:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 04/16] tests/functional: allow tuxrun tests to be
 passed "accel"
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
In-Reply-To: <20261012170330.1144446-5-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-5-alex.bennee@linaro.org>
Date: Tue, 13 Oct 2026 01:52:29 +0400
Message-Id: <179184194927.2190936.10183175705507398275.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=452;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=30MMr+NFtF7pN1P10FoXx2B7yyau+JXJGSwsduxjtY0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzVaeuslcz4AW2CQUHzqs+v3g+tpvLcyY74coI
 blM0GibQciJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1WngAKCRDa6OEJdZac
 5U9qD/oCv2449GDP7csPosnWjFXzfR26aEbTqqdwHB8fQ3+tmWX7YXiNIRT0FpddR7VQXqOSFdX
 t4EfnN37br7dNqg/Ht20irv+jH8xl3QkpNGqNK3vc1sFCDWliZfjoZ37LbuOnqepPrNMWsIhewx
 pei6mwPzX6q8dLclCgSkhAr/7zNoLZ7++0jhEIoHkMdqo1jjI5aanqTgqat3pSXAnhKusDCZKv4
 k9pBXvIBOTbe66P48LVz02EIE8tdXkz8Z5QF1LYcVWB6lXGYrBp2xPI8ZlhutZ68qZ4oKsCC5hE
 izqdueG/7kfV+PAUipxMSMMcexK0dJbDPU0s2jKE4FfpymgghwAJI3o4lc9O/3sqnSi9fmJxRxP
 IIoYVB8lJrP01MsUb7bZwlJ7X/cozHaN9DWRsTacz/riAgWixb0h0uzm+bDuwjrlwNxJNZEjdni
 uR4Moy2/DJkrjyyTMfdVvmVFyeeEqJCq1hHyQMxvOYT4WHz+AfyYymkengAxkS2ce9fPSTF++Qr
 e0DqiEp2aJ6VYvc19HoZgmv0n1t2AfDtQpXTQMvNyzbLgQjnl624zPZDTr/SS4x7W6TnHo7Ld3f
 U8aFoD5PRwdscs8oqyT6eL8AiW3Kt2/h2/Y9eLUbnWK6ZUI7/fp5gKt/s1z1FkQuTWC1nQLKCpX
 eEh8CneV8LlDIow==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Mon, 12 Oct 2026 18:03:18 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> For some tests we are about to add we want the flexibility to force
> "kvm" so give them that ability.
> 
> Message-ID: <20260930164649.433573-7-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


