Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632D4CCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjQc-0004cH-0F; Mon, 19 Oct 2026 05:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xIjQV-0004Xa-Pf
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xIjQT-0001vd-MT
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792401180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0y41bN6PyYIZ+lXbrCj4VRNLpWgxCT8kTOELMfaCUU=;
 b=XOdH68J/mz7f+Zg1vivp1RwceDNyfi8Mu/KpEsdTNrviewJTGUGCrgVF+BKjsYv94A7wtb
 ogmQ83Y1zlG8jWYNeNy3XvtYJNWXjo7QdYVRispIhovXG4X/lao7gDkqGnxXwlG7rdkwF9
 5LmBK4vUoSMEa8MhFR9ysmrd+xFOu2I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-MNYvwLQAOFC_OCmb2aY8PQ-1; Mon, 19 Oct 2026 09:12:59 +0000
X-MC-Unique: MNYvwLQAOFC_OCmb2aY8PQ-1
X-Mimecast-MFC-AGG-ID: MNYvwLQAOFC_OCmb2aY8PQ_1792401178
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48af4046a3bso1728025f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 02:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792401178; x=1793005978; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c0y41bN6PyYIZ+lXbrCj4VRNLpWgxCT8kTOELMfaCUU=;
 b=FO6/EJMDyEIBkZT96pcz2iM0cOxAkO6jmHNqRaeNb9KBZBlk7EIMRvpKQhbNhCLVKH
 n1jYNWuKjvuJxufP0ENXR7d1aEj81xRSHB65o5o8CnY88UXgjM26EiH89q7k6UFiSyHG
 AHogHWP1X1gaaVkUtxy9PHFvui6vbV3vivKNf0cp63KQuyGHTICRA17aoU6a126DdySS
 FbbD9JeSvQoWWWPgxQvntg5EOp+Y7I68nwYfrptcg9rHWWBcHW9/AxZcAQg6xvs9JrcK
 2wFcL6ZXp0Y6tIlIigx6/gr7semGj2T4HH1MJnuM5XwngS5fsSDkVnSD/ppfbLgtf6OL
 gg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401178; x=1793005978;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c0y41bN6PyYIZ+lXbrCj4VRNLpWgxCT8kTOELMfaCUU=;
 b=qTu+H2v4NVwNeGqwQ9+uwwN8aD2a5g+8lblmr5RwUFXqNWzuNcJFdf1vvS8XvdwlYo
 izQt+uhR+/KoyDKPQDuKe39g1GwbHGZgpOVe1n1dBr1T/ckEYPant9bm1yIif9OS7qCV
 +Ps92us+eApeIUODaL+5rDQ1Ozv9e/Aa/j7qo+KbfkfGR9SHME8o7xDIemsvxJL0dcd8
 RDtmNloRQMh956oMyERjxdSFHa+l8nR4zQLMnpCQLxbnHv7HIVlkkgYi2BV8G7W1xO+Y
 6OXIZmQylwGCCeJix9Mk28CL3rlZxKb6mb2/2hXRR5WsaGzes/6kci6jw6/GXcZjzelb
 BiIQ==
X-Gm-Message-State: AFq9FYIZXp6IptzTE0HQ2HGMp3AbPglq9tLKL0X3VBnskKaXjimFt8HD
 NOZ+MTY1922ufApbHMD8dac+fhaZB51w519E8NIsLTYpWm5v878PRzrnz7t020TvOftjucnxFHb
 n4ijXA6JZvboon+QCJ2hvoRk6cBP4lgjRTIDZJTqK2qESu8y7HhDYykQ2
X-Gm-Gg: AYBFou1lbsuCEtPk8IvyDWNw64YwBnE458UcAeHhidlFogsg9HIcR8Rrm8q+gEvNHlc
 5p/OkmVXR5WOYkDWW3GyMAvxq4gaDEuu+3+uhAEj11N/EBWdtpk+3t9jjhrCLNvwYiOkM4Igfl8
 DRL7C5Z4u3uoGXKzjO9i4x/dSve0vJ0r/eZNJFrPGjqGOHY+B/wBlUuvoJbEXRwlq6wADNJFs/Z
 pCWaMHgoacxGoczz3K5GyWH4yLkQMLLB0HqFOk87O/w+y/kQB7mixYjKWFDtpO+x03wMw1V7mH9
 Qqr69+PMGpXmL2N2pJWy6pYOIiA9+EQ1ElSZPgGR+pxyvkJCPvQd6ItRuvXIVdQNSXnp1c9VEoo
 KNhjWH57xa5z6RSzH4G5EjHl7N8/uUj+qJpAQpewqYWixAjy08ceo0Cg7xG3b6NcpfsUq
X-Received: by 2002:a05:6000:4021:b0:48e:c84:5be6 with SMTP id
 ffacd0b85a97d-48e0c845d7amr12405435f8f.14.1792401177959; 
 Mon, 19 Oct 2026 02:12:57 -0700 (PDT)
X-Received: by 2002:a05:6000:4021:b0:48e:c84:5be6 with SMTP id
 ffacd0b85a97d-48e0c845d7amr12405377f8f.14.1792401177525; 
 Mon, 19 Oct 2026 02:12:57 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.36.232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd50ae5esm24137600f8f.51.2026.10.19.02.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:12:56 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 19 Oct 2026 11:12:46 +0200
Subject: [PATCH v3 1/2] igvm: add command line parameter support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-igvm_command_line-v3-1-29aeacbd6cd7@redhat.com>
References: <20261019-igvm_command_line-v3-0-29aeacbd6cd7@redhat.com>
In-Reply-To: <20261019-igvm_command_line-v3-0-29aeacbd6cd7@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Add a "cmdline" property to the igvm-cfg object and a handler for the
IGVM_VHT_COMMAND_LINE directive, which copies the string into the
parameter area the directive points at.

The command line is passed to whatever software the IGVM file loads,
such as an SVSM. For example, SVSM can use it to select the serial port
it logs to.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm-cfg.c            | 21 +++++++++++++++++++++
 backends/igvm.c                | 31 +++++++++++++++++++++++++++++++
 include/system/igvm-internal.h |  5 +++++
 qapi/qom.json                  |  7 ++++++-
 qemu-options.hx                |  6 +++++-
 5 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 935ba54f54..653f79bef5 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -34,6 +34,19 @@ static void set_igvm(Object *obj, const char *value, Error **errp)
     igvm->filename = g_strdup(value);
 }
 
+static char *get_cmdline(Object *obj, Error **errp)
+{
+    IgvmCfg *igvm = IGVM_CFG(obj);
+    return g_strdup(igvm->cmdline);
+}
+
+static void set_cmdline(Object *obj, const char *value, Error **errp)
+{
+    IgvmCfg *igvm = IGVM_CFG(obj);
+    g_free(igvm->cmdline);
+    igvm->cmdline = g_strdup(value);
+}
+
 static ResettableState *igvm_reset_state(Object *obj)
 {
     IgvmCfg *igvm = IGVM_CFG(obj);
@@ -85,6 +98,13 @@ static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "file",
                                           "Set the IGVM filename to use");
 
+    object_class_property_add_str(oc, "cmdline", get_cmdline, set_cmdline);
+    object_class_property_set_description(oc, "cmdline",
+                                          "Set the command line for the "
+                                          "software loaded from the IGVM "
+                                          "file (copied verbatim, not "
+                                          "parsed by QEMU)");
+
     igvmc->process = qigvm_process_file;
 
     rc->get_state = igvm_reset_state;
@@ -112,4 +132,5 @@ static void igvm_cfg_finalize(Object *obj)
         igvm_free(igvm->file);
     }
     g_free(igvm->filename);
+    g_free(igvm->cmdline);
 }
diff --git a/backends/igvm.c b/backends/igvm.c
index ec7bee428b..d059fee4d2 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -158,6 +158,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
 static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        const uint8_t *header_data,
                                        Error **errp);
+static int qigvm_directive_command_line(QIgvm *ctx, const uint8_t *header_data,
+                                        Error **errp);
 #ifdef CONFIG_FDT
 static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
                                        Error **errp);
@@ -192,6 +194,8 @@ static struct QIGVMHandler handlers[] = {
       qigvm_initialization_guest_policy },
     { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
       qigvm_directive_madt },
+    { IGVM_VHT_COMMAND_LINE, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_command_line },
 #ifdef CONFIG_FDT
     { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
       qigvm_directive_device_tree },
@@ -851,6 +855,33 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     return 0;
 }
 
+static int qigvm_directive_command_line(QIgvm *ctx, const uint8_t *header_data,
+                                        Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    const char *cmdline = ctx->cfg->cmdline ? ctx->cfg->cmdline : "";
+    uint8_t *param_data;
+    uint32_t param_size;
+    size_t cmdline_size = strlen(cmdline) + 1;
+
+    param_data = qigvm_get_param_data(ctx, param, &param_size, errp);
+    if (!param_data) {
+        return -1;
+    }
+
+    if (cmdline_size > param_size) {
+        error_setg(errp,
+                   "IGVM: command line size %zu exceeds the %u byte "
+                   "parameter area defined in IGVM file",
+                   cmdline_size, param_size);
+        return -1;
+    }
+
+    memcpy(param_data, cmdline, cmdline_size);
+
+    return 0;
+}
+
 #ifdef CONFIG_FDT
 static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
                                        Error **errp)
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index b3b64cb584..b56a2e1254 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -32,6 +32,11 @@ struct IgvmCfg {
      *           format.
      */
     char *filename;
+    /*
+     * cmdline: Command line for the software loaded from the IGVM file,
+     *          if it asks for one.
+     */
+    char *cmdline;
     IgvmHandle file;
     ResettableState reset_state;
     QTAILQ_HEAD(, IgvmMemoryRegion) memory_regions;
diff --git a/qapi/qom.json b/qapi/qom.json
index 5895c97750..fe08d6d8f6 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1004,11 +1004,16 @@
 #
 # @file: IGVM file to use to configure guest
 #
+# @cmdline: command line for the software loaded from the IGVM file.
+#     Its format is specific to that software.  Passed verbatim: QEMU
+#     does not parse it.
+#     Ignored if the IGVM file does not ask for one.  (since 11.2)
+#
 # Since: 10.1
 ##
 { 'struct': 'IgvmCfgProperties',
   'if': 'CONFIG_IGVM',
-  'data': { 'file': 'str' } }
+  'data': { 'file': 'str', '*cmdline': 'str' } }
 
 ##
 # @SevCommonProperties:
diff --git a/qemu-options.hx b/qemu-options.hx
index 2f6863180b..f72f30e246 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6496,7 +6496,7 @@ SRST
                  -machine ...,confidential-guest-support=tdx \\
                  ......
 
-    ``-object igvm-cfg,file=file``
+    ``-object igvm-cfg,file=file[,cmdline=string]``
         Create an IGVM configuration object that defines the initial state
         of the guest using a file in that conforms to the Independent Guest
         Virtual Machine (IGVM) file format.
@@ -6509,6 +6509,10 @@ SRST
         memory of the virtual machine and, depending on the platform, can
         define the initial processor state, memory map and parameters.
 
+        The optional ``cmdline`` parameter is a command line passed
+        verbatim to the software loaded from the IGVM file, if the file
+        requests one. Its format is specific to that software.
+
         The IGVM file is expected to contain the firmware for the virtual
         machine, therefore an ``igvm-cfg`` object cannot be provided along
         with other ways of specifying firmware, such as the ``-bios``

-- 
2.56.0


