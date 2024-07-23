Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793B5C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDGP-0000R9-3g; Tue, 23 Jul 2024 07:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGL-0008Us-C9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGJ-00032D-LZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=23tk34UMbS5KN8DzcPjFZwgbF2YmEX25+n6MkYYLPTM=;
 b=Aa3/9TdreT9DRm4WZvb2F2W2otjgNCRYeXaCFatCfvUq93rJOLZViZrx2KInGyoTZng665
 MdramDFQTe3hwOFOxkA6cNbkhirmEcoNyqmjtDdbAI+FmeOg/xwQO7sYFz53lL3TtkIO4K
 w6AUD9velCVepGZ9vF0FEDPSv3j8QtA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-gRanoD9HNEukumnNNk3pVw-1; Tue, 23 Jul 2024 07:00:53 -0400
X-MC-Unique: gRanoD9HNEukumnNNk3pVw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7a9761bf6dso48912566b.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732452; x=1722337252;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23tk34UMbS5KN8DzcPjFZwgbF2YmEX25+n6MkYYLPTM=;
 b=FCFhF1qW3NgT2ennF52q88Iz3A3+xfL0uTjKYj4/47SZSeqNPFAxwmf2yESKKjxnzh
 FOnFAZZ7O6eTe0Zly+jTlr4c/vkAskgDpOIUXVir6bQ5ivSZWFJNRIHhShWQvmM2fIhI
 YDj6zTRreFnb0delKQa96vHRgFOWlWC2fT9Eg1I1/hb2XBEIHw8qxLBNPuzHn7xZC9sV
 wKybQAaV2G4Gz3UOqQE/gxi6C1gD7KKRmXh9vBorGgKGyHQSvHuqzupe8VO+qnwF2x0X
 pF6WeekEWeTCfHyhTYq1R8ugfd5S93LBjkLk+1zZpZfKmdMvXkLvYsiOFqVjKBwB46sh
 Ohow==
X-Gm-Message-State: AOJu0Yw9EBcBEkosUS5mG+3pNkRKrGNTzBwI/fF/RgL1M/cjyBZMvWn5
 UIJtk26d1gMugkDwvcP9t6zCq3npwJY9NEXgDeiqeXl0OhIo3OrP4NlDUlb6NLAq1LXP5vDwTeC
 ZeyPUalRiwwpLhvP7UXj9WknEWaUhoC2Nw0C50a7qPHcBc7HK8Zs3oKi3Jrql+EycICGgrXjv/i
 jZpGsb3pwTPxyI9ZgZFgi6Vfo7FJnY7w==
X-Received: by 2002:a17:907:3f23:b0:a77:dd1c:627a with SMTP id
 a640c23a62f3a-a7a4bfa22bfmr689300966b.8.1721732451738; 
 Tue, 23 Jul 2024 04:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBOQnXdyHeiqjUdHA5GvIGWN9almpKd08ifcygVg9qsL7rzHke9Nv5ARnxbgZTDQoTYD/tvQ==
X-Received: by 2002:a17:907:3f23:b0:a77:dd1c:627a with SMTP id
 a640c23a62f3a-a7a4bfa22bfmr689297366b.8.1721732450903; 
 Tue, 23 Jul 2024 04:00:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a9256553bsm71657966b.70.2024.07.23.04.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:00:50 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:00:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 55/61] tests/qtest/bios-tables-test.c: Remove the fall back
 path
Message-ID: <329b327924f7e1a7a735c91b31f722708599e10f.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Sunil V L <sunilvl@ventanamicro.com>

The expected ACPI AML files are moved now under ${arch}/{machine} path.
Hence, there is no need to search in old path which didn't have ${arch}.
Remove the code which searches for the expected AML files under old path
as well.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716144306.2432257-7-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index f4c4704bab..498e0e35d9 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -267,15 +267,6 @@ static void dump_aml_files(test_data *data, bool rebuild)
                                        data->arch, data->machine,
                                        sdt->aml, ext);
 
-            /*
-             * To keep test cases not failing before the DATA files are moved to
-             * ${arch}/${machine} folder, add this check as well.
-             */
-            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
-                aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir,
-                                           data->machine, sdt->aml, ext);
-            }
-
             if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
                 sdt->aml_len == exp_sdt->aml_len &&
                 !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
@@ -412,11 +403,6 @@ static GArray *load_expected_aml(test_data *data)
 try_again:
         aml_file = g_strdup_printf("%s/%s/%s/%.4s%s", data_dir, data->arch,
                                    data->machine, sdt->aml, ext);
-        if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
-            aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
-                                       sdt->aml, ext);
-        }
-
         if (verbosity_level >= 2) {
             fprintf(stderr, "Looking for expected file '%s'\n", aml_file);
         }
-- 
MST


