Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06F6C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 17:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgpub-0002KQ-Ol; Sun, 03 Mar 2024 12:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgpuW-0002Jr-Pe
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 12:46:08 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgpuV-0005WH-52
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 12:46:04 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33e2774bdc5so1128145f8f.2
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 09:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709487960; x=1710092760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXOsimm5b/J80I2W9cGrrHUnx2UJxTDevm55fAWLl+Y=;
 b=JZDZaayNZbhzM1LyeesmuLrENz0EcRX7gjF2OjmlQQYnxv3/wGEAD8CU/gnGLfVkIH
 y9alBz8vd0W/NGU/+JnwUJDkSGnSf/zk9X9w+pzWDlnMKY5D0eFKbLPI/7ZwueMfkEHN
 vCST95SkrYp3HdPE0BGz1THuXjV3gchmDrVMEnMr6oBnVVesLkmf2P2jdve9rqS+1cC8
 Ic7JGa9F0d23wfpYDWJqTmbuPliYv0XTOzoDU4ISkW32iexNmg036aFIl9rVBw8aKmq/
 XLq0YxejquxU4X9XuJK9OWYaz0NA8L4pj/tcKY4MgPgz6YIbrr3H1vZpntih523ip9Ad
 0UrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709487960; x=1710092760;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KXOsimm5b/J80I2W9cGrrHUnx2UJxTDevm55fAWLl+Y=;
 b=v2ZC/k2Z7gGlcqb5ybBRCOcB4v2snJZHT3XAWzX5jttNGVBDfA2y99miP5sNo0frRL
 Mf2Obe1y9jerKbbUKv2JsrIkNMVdibbl9QTxr89GCMI6vyezl9aDY9pY4JoD/BrCLHki
 10nvF71F8/SxUX5LJi17dE//lYXi25Dfn6W9OOwn5y9Wh6FgD8CLal7V44vvTmCdLOE0
 +LC+3gmrp5O+tM59GBWMLcUZrhj3Do617CTeEGz+Ac+G6dWYiB5uQJcIrfq+1faLADma
 JTQh6rjOuI3cU/qLIQK8BbeGVY6yw17umMtFd1b0h8LJpOaoJhLfW6PHIq3qi+Mq2k64
 YNbg==
X-Gm-Message-State: AOJu0YyB96vAYdZChyfRgLJqJgUG/gXSugQXnsa6qm2tMTUdYvWznyFA
 BY9fRk6D6a8NBHavbmzKFziHNL0toxaoG+TKbDrXn/diA8k9ZF1TqnjnB5dq
X-Google-Smtp-Source: AGHT+IEHyoDT4t9yLXHUJvyVbB2JSFBmSiU2UqaR++tFrkXfzArZtpooFUtircg4YPdWJRaI27gtLQ==
X-Received: by 2002:adf:c98c:0:b0:33c:f9d6:fb20 with SMTP id
 f12-20020adfc98c000000b0033cf9d6fb20mr4992115wrh.45.1709487959391; 
 Sun, 03 Mar 2024 09:45:59 -0800 (PST)
Received: from [127.0.0.1] (dynamic-092-224-118-014.92.224.pool.telefonica.de.
 [92.224.118.14]) by smtp.gmail.com with ESMTPSA id
 f15-20020adffccf000000b0033dedd63382sm10098443wrs.101.2024.03.03.09.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Mar 2024 09:45:58 -0800 (PST)
Date: Sun, 03 Mar 2024 17:45:59 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>,
 =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
CC: deller@gmx.de
Subject: Re: [PATCH v3 10/12] plugins: add range list API
In-Reply-To: <20240301174609.1964379-11-svens@stackframe.org>
References: <20240301174609.1964379-1-svens@stackframe.org>
 <20240301174609.1964379-11-svens@stackframe.org>
Message-ID: <7A337DB0-78D2-4891-8E8D-B7370CB8ED30@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 1=2E M=C3=A4rz 2024 17:46:07 UTC schrieb Sven Schnelle <svens@stackfram=
e=2Eorg>:
>Export range_list_from_string(), range_contains() and range_list_free()
>to allow plugins to parse filter ranges and match them to avoid
>reimplementing this functionality=2E
>
>Signed-off-by: Sven Schnelle <svens@stackframe=2Eorg>
>---
> include/qemu/qemu-plugin=2Eh   | 41 ++++++++++++++++++++++++++++++++++++
> plugins/api=2Ec                | 18 ++++++++++++++++
> plugins/qemu-plugins=2Esymbols |  3 +++
> 3 files changed, 62 insertions(+)
>
>diff --git a/include/qemu/qemu-plugin=2Eh b/include/qemu/qemu-plugin=2Eh
>index 5839feea4d=2E=2E4910a63d70 100644
>--- a/include/qemu/qemu-plugin=2Eh
>+++ b/include/qemu/qemu-plugin=2Eh
>@@ -765,4 +765,45 @@ typedef struct Error Error;
> QEMU_PLUGIN_API
> void qemu_plugin_error_print(Error *err);
>=20
>+typedef GList qemu_plugin_range_list;
>+
>+/**
>+ * qemu_plugin_ranges_from_string() - parse a filter range string
>+ *
>+ * @out_ranges: a pointer to a @qemu_plugin_range_list pointer
>+ * @filter_spec: input string
>+ * @errp: @Error string on parse failure
>+ *
>+ * This function parses a filter specification string and stores the
>+ * parsed adress ranges found in @out=2E On parse failure a @Error point=
er
>+ * is stored in @errp=2E The function accepts a comma-separated list
>+ * of start and end addresses or single addresses=2E
>+ */
>+QEMU_PLUGIN_API
>+void qemu_plugin_range_list_from_string(qemu_plugin_range_list **out_ran=
ge,

Nice series in general=2E One nitpick: When the API docs are generated I g=
et the following error:

    include/qemu/qemu-plugin=2Eh:788: warning: Function parameter or membe=
r 'out_range' not described in 'qemu_plugin_range_list_from_string'

This is due to the parameter being documented as "out_ranges" which seems =
like the more appropriate name given its type=2E It might also be cleaner t=
o have the same names in the source, too=2E

Best regards,
Bernhard

>+                                        const char *filter_spec,
>+                                        Error **errp);
>+
>+/**
>+ * qemu_plugin_range_list_contains() - match a value against a list
>+ * of ranges
>+ *
>+ * @ranges: a pointer to a @qemu_plugin_range_list
>+ * @val: the value to match
>+ *
>+ * This function matches @val against the adress range list in @ranges=
=2E
>+ * On success, true is returned, otherwise false=2E
>+ */
>+QEMU_PLUGIN_API
>+bool qemu_plugin_range_list_contains(qemu_plugin_range_list *ranges,
>+                                     uint64_t val);
>+
>+/**
>+ * qemu_plugin_range_list_free() - free a list of ranges
>+ *
>+ * @ranges: a pointer to the list to be freed
>+ */
>+QEMU_PLUGIN_API
>+void qemu_plugin_range_list_free(qemu_plugin_range_list *ranges);
>+
> #endif /* QEMU_QEMU_PLUGIN_H */
>diff --git a/plugins/api=2Ec b/plugins/api=2Ec
>index 8fd3a8964a=2E=2E8dbd14c648 100644
>--- a/plugins/api=2Ec
>+++ b/plugins/api=2Ec
>@@ -472,3 +472,21 @@ void qemu_plugin_error_print(Error *err)
>     error_report_err(err);
> }
>=20
>+void qemu_plugin_range_list_from_string(qemu_plugin_range_list **out,
>+                                        const char *filter_spec,
>+                                        Error **errp)
>+{
>+    return range_list_from_string(out, filter_spec, errp);
>+}
>+
>+bool qemu_plugin_range_list_contains(qemu_plugin_range_list *ranges,
>+                                     uint64_t val)
>+{
>+    return range_list_contains(ranges, val);
>+}
>+
>+void qemu_plugin_range_list_free(qemu_plugin_range_list *ranges)
>+{
>+    return range_list_free(ranges);
>+}
>+
>diff --git a/plugins/qemu-plugins=2Esymbols b/plugins/qemu-plugins=2Esymb=
ols
>index b142d11e58=2E=2E472b29fc5f 100644
>--- a/plugins/qemu-plugins=2Esymbols
>+++ b/plugins/qemu-plugins=2Esymbols
>@@ -21,6 +21,9 @@
>   qemu_plugin_num_vcpus;
>   qemu_plugin_outs;
>   qemu_plugin_path_to_binary;
>+  qemu_plugin_range_list_contains;
>+  qemu_plugin_range_list_free;
>+  qemu_plugin_range_list_from_string;
>   qemu_plugin_read_register;
>   qemu_plugin_register_atexit_cb;
>   qemu_plugin_register_flush_cb;

