Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23462CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQFp-0002w3-TD; Wed, 10 Jun 2026 17:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQFn-0002vb-FM
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQFl-0005pH-Vp
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DfW0v2EfgC3GDM3f0Q5lTs2l+Lk9TLXJizaCcRW9728=;
 b=WhMoUYPGdq284U8pUy3TYIyEuwN7AOy3z+bLwsmxLSJNRJD4UH6CUjV1hFbsQyyFWBp1if
 ebsLpI/2u7O3NZI3z/GngA3CBVaaWD9nMZ9SfCUl/F2fyvia8j01xv7opXRzKuENNGGty4
 X0nxXg1QMOiyykPJqnczkV9UceDioX4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-6NkaYoWHOiitzKy80b_rDw-1; Wed,
 10 Jun 2026 17:14:22 -0400
X-MC-Unique: 6NkaYoWHOiitzKy80b_rDw-1
X-Mimecast-MFC-AGG-ID: 6NkaYoWHOiitzKy80b_rDw_1781126061
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23BD419560AE; Wed, 10 Jun 2026 21:14:21 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCF5C1954B10; Wed, 10 Jun 2026 21:14:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 06/35] monitor: add 'chardev' property to Monitor
 base class
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
In-Reply-To: <20260610123415.2883603-7-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-7-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600325.209622.9037016260369859761.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eMCSTdUF6ZK9u4vMRZf/ZpefBL1csLOamvw4UcxMdf4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdN++JH2ZgVpucQTT6r6HLfsSLjWu+Z1oxNBt
 p5jf0i3bxWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTfgAKCRDa6OEJdZac
 5UOvD/9c6STaBN0wBSQRlpua5GyX9ebenFlu5wuYtlXWxIzysL4da1O2VPvC+iDIcXdy+icYN23
 LhyNHrNc4a8rIvfqJAlMVa4FKR1xQtZDe+baRlZI++ddBLVsXrx1m7U7zWXnfXwJDJa2nyGbEk0
 3A1XdaGxzT094PXw3M6zuui+epQ/mUJ60+RTRRY5/stp8bbWkVUGpr2gHSzRJsqCZ/CsABgH6Qg
 8LkYAXOSQszd2z9d5NyZuxyyS1Iq8siRDmozpNo4Bmpoe8+ZUt6MsyrJuLZlA41ozVTh2pQ2Gp9
 +IHCWTWh9fxGyuxnwUp/lTxNlo8rNEqSs+r1WKG1IQo+bXBpHMinAPyyUb0XB5l5rO3ktku0YLL
 fue7fgQhQyYI6cxJhLczYfM8gaFkMBV5gz3Raom2LV3xU318HNMUxeTLhazDvkjnGUkRLn/p4rn
 k3fV324qr+d+SprmfCNK+uGBPqAlA00EQcAOBupuAo0CeUbV7zsQVHTm5/S5shiIzs4q6ndkBmX
 DibR5L+OVWqYWgn9QEEe+x6qLUxUTQZLpIolJsiM8CIVz47Nsbc1HUZ+hK8pUD3SgzwhKi4tQAy
 jrK7AxGX2fMIbMGwuSwHd+D8+/UA8GbDdj7kIFOdkybfMwMshZeRhcEWFA/fkUiRhlaA0DWjwPL
 HQn1+d8PfVkToRQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Wed, 10 Jun 2026 13:33:46 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index a497c25c543..1f1f5fe9fe3 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -77,10 +77,30 @@ OBJECT_DEFINE_TYPE(Monitor, monitor, MONITOR, OBJECT);
> [ ... skip 14 lines ... ]
> +
> +static void monitor_set_chardev_id(Object *obj, const char *str, Error **errp)
> +{
> +    Monitor *mon = MONITOR(obj);
> +
> +    mon->chardev_id = g_strdup(str);

missing g_free(mon->chardev_id) before.

>
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 5231ed506a5..3a4e2ae0e7a 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -527,7 +527,7 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
>      monitor_list_append(&mon->parent_obj);
>  }
>  
> -void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
> +void monitor_new_qmp(const char *chardev_id, bool pretty, Error **errp)
>  {
>      MonitorQMP *mon;
>      static int counter;

Add ERRP_GUARD(), like monitor_new_hmp()

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


