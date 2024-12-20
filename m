Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548C3E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 17:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOgkA-0000Lb-Ly; Fri, 20 Dec 2024 12:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOgk4-0000Kn-DH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 12:24:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOgk2-0002Wh-L8
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 12:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734715484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlYJaGZvxhT+59D9zsDgpov38HXed8A0vZ1hKlymbyY=;
 b=DCzf3mJMp3B1aWcMF67WeHBfeELFWWEQ//1UZecmMGuU4BbgUsuwvix8yCCtg0RB0+3Bpu
 xJvp7eki5Bbf/7DgRcMzdFyRd9/aNIm39E4C/9THvS/lovIeO+Gyyhg/Ezo/VFJfbEzQ71
 XiaSgJZpuEUThtrbxabODOF9b6TDILY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-zthq06-vNpWPi3XLcims3Q-1; Fri, 20 Dec 2024 12:24:43 -0500
X-MC-Unique: zthq06-vNpWPi3XLcims3Q-1
X-Mimecast-MFC-AGG-ID: zthq06-vNpWPi3XLcims3Q
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-467b19b55d6so25940981cf.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 09:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734715483; x=1735320283;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nlYJaGZvxhT+59D9zsDgpov38HXed8A0vZ1hKlymbyY=;
 b=gSzYsMqWI96YwCpHsHLUTwN+daSF1sJmmd3Ov+76fkAvEtElpgqCv4nfFurJDM/7D+
 w5CaHXtTiDXF/hCeiKypXYbAoairD89nYO9l4npdGJUJHcmIroDtfI/i7Xf67cUBDkOo
 jPs2oAXo6UkjbXQdTsAb1dEwFQH8qEphcQVoha1qUga+IfyUimvFHLlOe4/S7YEzKnO9
 W6jJ0HQPln9XaoNZDVHL2E4de/8naOgTmtfLaRkRrjKBhHJTfwikDZRnq7OJjOpuwprY
 BCmO7eq1IauEpCL/qcNw9H5VFfZNiwC9/eeoeKzf0XJwH7svG/ZUjhZXtRck7IiX7sXg
 WzqQ==
X-Gm-Message-State: AOJu0YxoeHyngb9YJJFzxTMltqJTFNeRxlwo2adCM3O1DQ+NQ4PjtTk2
 U/xlKnGByaJsbhTioQ/s5wsAFMS1TuJ//aUf8PKmAxu9bTRJhNcL94QAaltzVxOVuByjo1fRsbb
 Nr7zWyCce8RRGx6E1gB/wKuwwLv95LdZsgAI2fbo8sZIDy481q5es
X-Gm-Gg: ASbGncu+bIILANmmrOcthCxWQIWBv4UeFNTafj2g6da3ORwHoCxqJTHeOsz4e94mdOP
 Zsc3v1kGfRpSEhJqWXkZUUFmlfTGWfDvAs2l2N9SGur/mraJhj0wr+S/5EaSjRJvJe5pt/INden
 0sPNGoWRMkA6OVAEPtMMzIUrwN8LyW8pO7REwtWW8LlZ5oJSS2FEp8wGfsbLTy6glw1Zl3HN00Q
 ryX2C+752clPM9r1KCO5yFIw/e74dFQzlOwdSOrsjYIv7xYyoMKWvxV6LcdRhxDpyGCpU15jlOp
 HJqhvK1vwYX9VMyocw==
X-Received: by 2002:a05:622a:1a9f:b0:467:4f0a:1b5d with SMTP id
 d75a77b69052e-46a4a989b51mr58416811cf.42.1734715482778; 
 Fri, 20 Dec 2024 09:24:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLeHeK9I+EyM4jZijhZwJRbpVMNqNTMySYBMt5WHcWTDFBha5MMXcHKzot0A9A1seIZgWk8g==
X-Received: by 2002:a05:622a:1a9f:b0:467:4f0a:1b5d with SMTP id
 d75a77b69052e-46a4a989b51mr58416401cf.42.1734715482338; 
 Fri, 20 Dec 2024 09:24:42 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e64cb04sm18656721cf.8.2024.12.20.09.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 09:24:41 -0800 (PST)
Date: Fri, 20 Dec 2024 12:24:39 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 08/13] qdev: Make qdev_get_machine() not use
 container_get()
Message-ID: <Z2WoVxB8GfdJj6KM@x1n>
References: <20241121192202.4155849-1-peterx@redhat.com>
 <20241121192202.4155849-9-peterx@redhat.com>
 <dbe21846-ea9e-47b6-83c4-6ee350e891e5@linaro.org>
 <a0e5950d-2de8-4500-8376-88c231818aed@linaro.org>
 <fe9d34bf-5a68-42e3-ad00-c8f22551865c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe9d34bf-5a68-42e3-ad00-c8f22551865c@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Dec 20, 2024 at 12:25:44PM +0100, Philippe Mathieu-Daudé wrote:
> On 19/12/24 19:27, Philippe Mathieu-Daudé wrote:
> > On 19/12/24 19:20, Philippe Mathieu-Daudé wrote:
> > > On 21/11/24 20:21, Peter Xu wrote:
> > > > Currently, qdev_get_machine() has a slight misuse on container_get(), as
> > > > the helper says "get a container" but in reality the goal is to get the
> > > > machine object.  It is still a "container" but not strictly.
> > > > 
> > > > Note that it _may_ get a container (at "/machine") in our
> > > > current unit test
> > > > of test-qdev-global-props.c before all these changes, but it's probably
> > > > unexpected and worked by accident.
> > > > 
> > > > Switch to an explicit object_resolve_path_component(), with a
> > > > side benefit
> > > > that qdev_get_machine() can happen a lot, and we don't need to split the
> > > > string ("/machine") every time.  This also paves way for making
> > > > the helper
> > > > container_get() never try to return a non-container at all.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >   hw/core/qdev.c | 7 ++++++-
> > > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > > > index 5f13111b77..b622be15ee 100644
> > > > --- a/hw/core/qdev.c
> > > > +++ b/hw/core/qdev.c
> > > > @@ -817,7 +817,12 @@ Object *qdev_get_machine(void)
> > > >       static Object *dev;
> > > >       if (dev == NULL) {
> > > > -        dev = container_get(object_get_root(), "/machine");
> > > > +        dev = object_resolve_path_component(object_get_root(),
> > > > "machine");
> > > > +        /*
> > > > +         * Any call to this function before machine is created
> > > > is treated
> > > > +         * as a programming error as of now.
> > > > +         */
> > > > +        assert(dev);
> > > 
> > > This fails for user-emulation:
> > > 
> > > ./qemu-x86_64 /bin/echo foo
> > > qemu-x86_64: ../../hw/core/qdev.c:825: qdev_get_machine: Assertion
> > > `dev' failed.
> 
> OK so I guess I might have found a "fix" which is to simply not
> call qdev_get_machine() for user emulation, but this involves some
> invasive refactoring -- so will take time --.

Thanks for taking a look, Phil.  Yes this sounds clean.

> 
> I'm dropping this series for now, planning to merge it again on top
> of my refactor once it is ready. Any clever / simpler fix is
> obviously welcomed first.

I initially thought about this, which could also be clean but I then
noticed LINUX_USER is poisoned..

===8<===
diff --git a/qom/object.c b/qom/object.c
index 58897a79a7..da26e8d69b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1729,7 +1729,19 @@ const char *object_property_get_type(Object *obj, const char *name, Error **errp
     return prop->type;
 }

+/*
+ * Create all QEMU default containers.
+ *
+ * For system emulations, "machine" and its sub-containers are only created
+ * when machine initializes (qemu_create_machine()).
+ *
+ * For user emulations, create "machine" before hand to make qdev realize()
+ * work by default.
+ */
 static const char *const root_containers[] = {
+#ifdef CONFIG_LINUX_USER
+    "machine",
+#endif
     "chardevs",
     "objects",
     "backend"
@@ -1740,10 +1752,6 @@ static Object *object_root_initialize(void)
     Object *root = object_new(TYPE_CONTAINER);
     int i;

-    /*
-     * Create all QEMU system containers.  "machine" and its sub-containers
-     * are only created when machine initializes (qemu_create_machine()).
-     */
     for (i = 0; i < ARRAY_SIZE(root_containers); i++) {
         object_property_add_new_container(root, root_containers[i]);
     }
===8<===

Maybe we could still move it somewhere that LINUX_USER is not poisoned
(plus "unattached" be created too, more below)?

OTOH, this works for me:

===8<===
diff --git a/linux-user/main.c b/linux-user/main.c
index b09af8d436..009b7695f2 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -819,6 +819,11 @@ int main(int argc, char **argv, char **envp)
     set_preferred_target_page_bits(ctz32(host_page_size));
     finalize_target_page_bits();
 
+    Object *fake_obj = object_property_add_new_container(object_get_root(),
+                                                         "machine");
+    object_property_add_new_container(fake_obj, "unattached");
+
     cpu = cpu_create(cpu_type);
     env = cpu_env(cpu);
     cpu_reset(cpu);
===8<===

So we need both "/machine" and "/machine/unattached" so far to make
linux-user work.  Not sure if bsd-user/main.c needs similar care, but none
of these look as clean.

Thanks,

-- 
Peter Xu


