Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32309CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMyn-00060t-LK; Fri, 08 May 2026 11:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLMyZ-0005xR-Q1
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLMyX-0003YZ-No
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778253526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NYMVVAJsC2vUNi7k8lCaESn3hh/rxcHVzba+YxAQedQ=;
 b=N81C3VR06oCi7r/XtDqiOn+ksffpVxYYu4HLHIdK4tYELPvwJLV1QxRbNBTiQxDjLhrIli
 pIGawknFe3aP/mJeLd2UZosKJcYlMjehZqNo1bZlGguT4Tmp8w0VL+lmcG3xI8LLnaJU+0
 FqH914vbk3cZ4xh0eteGy5zUpgIFaK8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-l1Ajfj8dMCSMTsebTPbfLw-1; Fri,
 08 May 2026 11:18:43 -0400
X-MC-Unique: l1Ajfj8dMCSMTsebTPbfLw-1
X-Mimecast-MFC-AGG-ID: l1Ajfj8dMCSMTsebTPbfLw_1778253522
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 150B31956095; Fri,  8 May 2026 15:18:42 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0C9118004A3; Fri,  8 May 2026 15:18:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/10] qom: add trace events for object/property
 lifecycle
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260508112429.643360-2-berrange@redhat.com>
References: <20260508112429.643360-1-berrange@redhat.com>
 <20260508112429.643360-2-berrange@redhat.com>
Date: Fri, 08 May 2026 19:18:29 +0400
Message-Id: <177825350908.389613.14807854790738677316.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Ls32KAnDDmgCX5RckkQOEl4JxBccmjngEjtmSOmNnlI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp/f7JYFpY9X11r346K9DvsACvAkUOAaeprQD/r
 g1n4KlmA+OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaf3+yQAKCRDa6OEJdZac
 5ZAvD/953DqQeEWzO4lwaI/0CV/9MAkxy+y7b5LV19CSrvlb3JwsQjLSgxDyq+TTsUmGSUt240G
 +heNKlMSw52afo7V6qPZPMmAvxiK8cbmZtpW6MUiIrAoFojLyZh5dx8ZC26XLk1emtzhdY9jH+Q
 Nq4YFJxnmXz9vPPC4k0bPa4iNMPQ+fHRuXPFDhI5SC+egalidkSwnXrMwPoXoej+ssRfdWbLH6Z
 ekNZDQJcUAjezVsdL1/QM7R/7SaZa5hYi39r374mgCimsGEFNHfYaiG0Rdm4+ZfgTRPAZ8/dzxv
 Xc6fDenEAhSOuEAQhrikpz7iKUp5wC+4fKF8EHv4ku4uOH2nf++oKt6xS4MxnhPQGAA93GvzXm+
 XzJ9KJgRJt3gaAiZM9cNI9bbgyKDI1VJM7fsJID2+B3ga7SsB1fiOYwEBb55iPcWRqOWcEIZTde
 xMzyBqHDF7BFgw6Ds26I93qywVP/8mUA0yJiWzJwBarHCDYk0vlOwjBsQo6kF/58Vn7PRY6BZG4
 68mhKq/05+FpHHrjuM3zwSZ2/Z0wlikYf2scQyrdn6k6BlFurkX8uQjtCB/ZkcOGgYYmPvibw5o
 4TIaWx/B0EnP02skQ24vjGkgNdA82RoSnC9t7BS8xj5sGmucTNvTXuQGOJ1TMm8gs8rAIRGwEXU
 quIv3leTwberq+g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 08 May 2026 12:24:20 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> diff --git a/qom/trace-events b/qom/trace-events
> index b2e9f4a7127..9aabbae4f73 100644
> --- a/qom/trace-events
> +++ b/qom/trace-events
> @@ -1,5 +1,13 @@
>  # See docs/devel/tracing.rst for syntax documentation.
>  
>  # object.c
> -object_dynamic_cast_assert(const char *type, const char *target, const char *file, int line, const char *func) "%s->%s (%s:%d:%s)"
> -object_class_dynamic_cast_assert(const char *type, const char *target, const char *file, int line, const char *func) "%s->%s (%s:%d:%s)"
> +object_dynamic_cast_assert(void *obj, const char *type, const char *target, const char *file, int line, const char *func) "obj=%p type=%s->%s (%s:%d:%s)"
> +object_finalize(void *obj, const char *type) "obj=%p type=%s"
> +object_new(void *obj, const char *type) "obj=%p type=%s"
> +object_property_add(void *obj, const char *type, const char *name, void *value) "obj=%p type=%s name=%s value=%p"
> +object_property_add_child(void *obj, const char *type, const char *name, void *parent, const char *parenttype) "obj=%p type=%s name=%s parent=%p parent-type=%s"

The 4th and 5th parameters are the child being added, not a parent.
In object_property_try_add_child the call is:

  trace_object_property_add_child(obj, ..., child, child->class->type->name)

So the parameter names should be "child"/"childtype" and the format
string should use "child=" / "child-type=".

> +object_property_del(void *obj, const char *type, const char *name, void *value) "obj=%p type=%s name=%s value=%p"
> +object_property_del_child(void *obj, const char *type, void *parent, const char *parenttype) "obj=%p type=%s parent=%p parent-type=%s"

Same here

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


