Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34651C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRGd-0004os-Qc; Mon, 29 Jul 2024 10:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sYRGc-0004gh-Sk
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sYRGZ-0004PZ-6E
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722262941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XorokIzlYwpbele6tLNnz8WKmNxwLFhApoSu+BhyQ7Q=;
 b=LWqVCZML4qw+UNEqi+dYTvcMGTaDWwfKqUcC6Dgv1AH8TEsJDM9gpKnsEhE9Nnnx3d3ceh
 9UFCuQq7Qu2LLSKF0BQNT3quKnYH1mzacG1qoHCzISpdif0xEs4dPVpHftBlEkPN3U7fcG
 jkbst8qpOtOTVkYj2S3llIST5qsRYu0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-_8vButAKOb6ShtO5UnDz2g-1; Mon, 29 Jul 2024 10:22:19 -0400
X-MC-Unique: _8vButAKOb6ShtO5UnDz2g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-368665a3fdfso1454653f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722262938; x=1722867738;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XorokIzlYwpbele6tLNnz8WKmNxwLFhApoSu+BhyQ7Q=;
 b=Y0wSZNzlV2xFlVixJSvdPVDqEUo0Ds5sJGEl/EO7SCCEYjqgNvnt+VYGc4TkLrDOY9
 DkklJZ/m9oKS5DAwm4zFWJ5Wniz1zKu3k2xPn+rqLFJIoRSJD+RFJoG8lwhL7YurMIuD
 QcV+U2P6c/REIANIAcge5PPgEjXnXHNmAIb5wEQ1dWRskNpOpaXYRZbOiRSPt9TDWFjC
 n5AAIrGBlFFWcXGsmgGEVF9gY+6580KFpSJMiJW3IDswfOdfV/VuMAi537iYllPio+tE
 VOMwI2ObVoIaRA9A4ck5ZYR2a6DV73cs2lYwWrnhZ0TLdwlNY0/t05QIMpiffAuB267p
 nTww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTwNI+zlkUC+hTyAxCOSFyl3men4R/a6TE+ipcglYG+VXedbfMPrJvCBejRj0fwYz3PNU+XGTB85Z2TYUpuchrNoIwVWM=
X-Gm-Message-State: AOJu0YzhRNw/6YfgQbFADH1x49ZOWPIKQKy1ILAUM+PAoX7OJhqkD9yW
 452lhhkKPxnuqcWHjhgjsEShoAYaB7b0vqgkEdkIkqw5raKtB20BBCyRcs699Yv5l86pTO5Rzem
 zo8NOVkvbbRc3CxK5fQ29lsePjt7DQBBXT+nUvE+SAwpX+s9lGItY
X-Received: by 2002:a05:6000:1082:b0:368:7943:146f with SMTP id
 ffacd0b85a97d-36b5d03c2c9mr4546356f8f.26.1722262938567; 
 Mon, 29 Jul 2024 07:22:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1OCncZleLYjN7F35l7QiUtsJX/cS5EY0ysxfX1ES6y5D4zGz8oKMhkiRY2cm+47iBxdg5HQ==
X-Received: by 2002:a05:6000:1082:b0:368:7943:146f with SMTP id
 ffacd0b85a97d-36b5d03c2c9mr4546338f8f.26.1722262937958; 
 Mon, 29 Jul 2024 07:22:17 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36863b45sm12551442f8f.107.2024.07.29.07.22.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 07:22:17 -0700 (PDT)
Message-ID: <f42a8801-f49d-48b6-84a4-467c89e78657@redhat.com>
Date: Mon, 29 Jul 2024 16:22:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/s390x: move @deprecated-props to
 CpuModelExpansion Info
To: Markus Armbruster <armbru@redhat.com>
Cc: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, thuth@redhat.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net
References: <20240726203646.20279-1-walling@linux.ibm.com>
 <877cd7qsnj.fsf@pond.sub.org>
 <00bc2317-dbba-43b3-b355-ddce45b5dfc6@redhat.com>
 <87a5i0cmht.fsf@pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87a5i0cmht.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

>>> The simplest way to address 4 is to tack 'if': 'TARGET_S390X' to
>>> @deprecated-props.
>>>
>>
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index 09dec2b9bb..0be95d559c 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -253,7 +253,7 @@
>>    ##
>>    { 'struct': 'CpuModelExpansionInfo',
>>      'data': { 'model': 'CpuModelInfo',
>> -            '*deprecated-props': ['str'] },
>> +            '*deprecated-props' : { 'type': ['str'], 'if': 'TARGET_S390X' } },
>>      'if': { 'any': [ 'TARGET_S390X',
>>                       'TARGET_I386',
>>                       'TARGET_ARM',
>>
>>
>> Should do the trick, right?
> 
> Yes.  Break the line before 'if', please.

Ack

[...]

> 
> Questions?

As clear as it can get, thanks! :)

That would leave us with:


 From 8be206168e31b9c3ff89e2b99c57a85d30150194 Mon Sep 17 00:00:00 2001
From: Collin Walling <walling@linux.ibm.com>
Date: Fri, 26 Jul 2024 16:36:46 -0400
Subject: [PATCH] target/s390x: move @deprecated-props to CpuModelExpansion
  Info

CpuModelInfo is used both as command argument and in command
returns.

Its @deprecated-props array does not make any sense in arguments,
and is silently ignored.  We actually want it only as return value
of query-cpu-model-expansion.

Move it from CpuModelInfo to CpuModelExpansionType, and document
its dependence on expansion type property.

This was identified late during review [1] and we have to fix it up
while it's not part of an official QEMU release yet.

[1] https://lore.kernel.org/qemu-devel/20240719181741.35146-1-walling@linux.ibm.com/

Message-ID: <20240726203646.20279-1-walling@linux.ibm.com>
Fixes: eed0e8ffa38f ("target/s390x: filter deprecated properties based on model expansion type")
Signed-off-by: Collin Walling <walling@linux.ibm.com>
[ david: - add "Fixes", adjust description, reference v3 instead
          - make property s390x-only and non-optional ]
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  qapi/machine-target.json         | 19 +++++++++++--------
  target/s390x/cpu_models_sysemu.c | 29 ++++++++++++++++++-----------
  2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index a552e2b0ce..00bbecc905 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -20,17 +20,11 @@
  #
  # @props: a dictionary of QOM properties to be applied
  #
-# @deprecated-props: a list of properties that are flagged as deprecated
-#     by the CPU vendor.  These properties are either a subset of the
-#     properties enabled on the CPU model, or a set of properties
-#     deprecated across all models for the architecture.
-#
  # Since: 2.8
  ##
  { 'struct': 'CpuModelInfo',
    'data': { 'name': 'str',
-            '*props': 'any',
-            '*deprecated-props': ['str'] } }
+            '*props': 'any' } }
  
  ##
  # @CpuModelExpansionType:
@@ -248,10 +242,19 @@
  #
  # @model: the expanded CpuModelInfo.
  #
+# @deprecated-props: a list of properties that are flagged as deprecated
+#     by the CPU vendor.  The list depends on the CpuModelExpansionType:
+#     "static" properties are a subset of the enabled-properties for
+#     the expanded model; "full" properties are a set of properties
+#     that are deprecated across all models for the architecture.
+#     (since: 9.1).
+#
  # Since: 2.8
  ##
  { 'struct': 'CpuModelExpansionInfo',
-  'data': { 'model': 'CpuModelInfo' },
+  'data': { 'model': 'CpuModelInfo',
+            'deprecated-props' : { 'type': ['str'],
+                                   'if': 'TARGET_S390X' } },
    'if': { 'any': [ 'TARGET_S390X',
                     'TARGET_I386',
                     'TARGET_ARM',
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index 94dd798b4c..6c8e5c7260 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -174,15 +174,11 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
                                  bool delta_changes)
  {
      QDict *qdict = qdict_new();
-    S390FeatBitmap bitmap, deprecated;
+    S390FeatBitmap bitmap;
  
      /* always fallback to the static base model */
      info->name = g_strdup_printf("%s-base", model->def->name);
  
-    /* features flagged as deprecated */
-    bitmap_zero(deprecated, S390_FEAT_MAX);
-    s390_get_deprecated_features(deprecated);
-
      if (delta_changes) {
          /* features deleted from the base feature set */
          bitmap_andnot(bitmap, model->def->base_feat, model->features,
@@ -197,9 +193,6 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
          if (!bitmap_empty(bitmap, S390_FEAT_MAX)) {
              s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_enabled_feat);
          }
-
-        /* deprecated features that are a subset of the model's enabled features */
-        bitmap_and(deprecated, deprecated, model->features, S390_FEAT_MAX);
      } else {
          /* expand all features */
          s390_feat_bitmap_to_ascii(model->features, qdict,
@@ -213,9 +206,6 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
      } else {
          info->props = QOBJECT(qdict);
      }
-
-    s390_feat_bitmap_to_ascii(deprecated, &info->deprecated_props, list_add_feat);
-    info->has_deprecated_props = !!info->deprecated_props;
  }
  
  CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
@@ -226,6 +216,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
      CpuModelExpansionInfo *expansion_info = NULL;
      S390CPUModel s390_model;
      bool delta_changes = false;
+    S390FeatBitmap deprecated_feats;
  
      /* convert it to our internal representation */
      cpu_model_from_info(&s390_model, model, "model", &err);
@@ -245,6 +236,22 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
      expansion_info = g_new0(CpuModelExpansionInfo, 1);
      expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
      cpu_info_from_model(expansion_info->model, &s390_model, delta_changes);
+
+    /* populated list of deprecated features */
+    bitmap_zero(deprecated_feats, S390_FEAT_MAX);
+    s390_get_deprecated_features(deprecated_feats);
+
+    if (delta_changes) {
+        /*
+         * Only populate deprecated features that are a
+         * subset of the features enabled on the CPU model.
+         */
+        bitmap_and(deprecated_feats, deprecated_feats,
+                   s390_model.features, S390_FEAT_MAX);
+    }
+
+    s390_feat_bitmap_to_ascii(deprecated_feats,
+                              &expansion_info->deprecated_props, list_add_feat);
      return expansion_info;
  }
  
-- 
2.45.2


-- 
Cheers,

David / dhildenb


