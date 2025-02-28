Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF4EC19F32
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 03:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnqfa-0001cO-Ub; Thu, 27 Feb 2025 22:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tnqfS-0001Ll-Po; Thu, 27 Feb 2025 22:04:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tnqfM-00063r-1A; Thu, 27 Feb 2025 22:04:02 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S18w5u011425;
 Fri, 28 Feb 2025 03:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=u4ON5LG3tSZrnd5AjNA9J6TmWBJz1k
 toOvLlrwQ15aI=; b=px2Wf0Qc1g85/QisM+MzdPE8uIqc0UJoj7ldogJs9FMa2Z
 nP2j/eBveKucHLMow9FiF/ty7PWXwbt2/a0Kcv+uTXdPhALCDjp7FayhG8/Hivi8
 W0GYC1Feq0oCmN3XnHIJEEUT2t44c1LnOwnw6STFRy4p4nMCZ/oVAL5Mb/pDgj2P
 6CnzpgazbAeZ3sjPdfu8GrL3pZxD42UesMCSn4NNAy7mXHQQF1CkeIKhOJgF+9m0
 hbZx+trOBsQ+Or1ZFN3XunlsNYTwx+/ryAvrjSW6sn24kOBhzqoWXpha4J62/hrd
 FOxjXB73IINMzo/bdkeiDW1x2lZ+YQfOXz4gb+IQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45337agdaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 03:03:41 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51S31rUw017511;
 Fri, 28 Feb 2025 03:03:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45337agdad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 03:03:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51S1lah2026285;
 Fri, 28 Feb 2025 03:03:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswnv7rm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 03:03:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51S33SRh55378346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2025 03:03:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C363B2004B;
 Fri, 28 Feb 2025 03:03:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 397C420043;
 Fri, 28 Feb 2025 03:03:26 +0000 (GMT)
Received: from [9.43.106.183] (unknown [9.43.106.183])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Feb 2025 03:03:25 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------ep5GSil7vjuEUqVZeaJwvN9f"
Message-ID: <b4430243-942b-43fc-9502-c0a328cecdc3@linux.ibm.com>
Date: Fri, 28 Feb 2025 08:33:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] hw/ssi/pnv_spi: Make bus names distinct for each
 controllers of a socket
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, clg@kaod.org,
 calebs@linux.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
References: <20250103161824.22469-1-chalapathi.v@linux.ibm.com>
 <20250103161824.22469-4-chalapathi.v@linux.ibm.com>
 <D82UR4MO7WG9.RGLCRWPS8I29@gmail.com>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <D82UR4MO7WG9.RGLCRWPS8I29@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pU7-wBs-MBPxWo9ow2pRCoZHmptTyjq0
X-Proofpoint-GUID: f_Zx2XAPE5eAubQA1KKmOfLu057Ripqo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280016
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is a multi-part message in MIME format.
--------------ep5GSil7vjuEUqVZeaJwvN9f
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 27-02-2025 07:24, Nicholas Piggin wrote:
> On Sat Jan 4, 2025 at 2:18 AM AEST, Chalapathi V wrote:
>> Create a spi buses with distict names on each socket so that responders
>> are attached to correct SPI controllers.
>>
>> QOM tree on a 2 socket machine:
>> (qemu) info qom-tree
>> /machine (powernv10-machine)
>>    /chip[0] (power10_v2.0-pnv-chip)
>>      /pib_spic[0] (pnv-spi)
>>        /chip0.pnv.spi.bus.0 (SSI)
>>        /xscom-spi[0] (memory-region)
>>    /chip[1] (power10_v2.0-pnv-chip)
>>      /pib_spic[0] (pnv-spi)
>>        /chip1.pnv.spi.bus.0 (SSI)
>>        /xscom-spi[0] (memory-region)
> Mechanics of the patch looks fine. I don't know about the name
> though.
>
> I think "pnv-spi-bus" is the right name for the bus. Using dots as
> with chip0. makes it seem like each element is part of a topology.
>
> Would chip0.pnv-spi-bus be better?
Will rename the bus name to chip0.pnv-spi-bus . Thank You
>
> I don't suppose there is a good way to create an alias so existing
> cmdline works and refers to the bus on chip0? Maybe the chip0 bus
> could just not have the chip0. prefix?
>
> Thanks,
> Nick
Would it be best to keep the chip0 prefix to have uniformity?
>> Signed-off-by: Chalapathi V<chalapathi.v@linux.ibm.com>
>> ---
>>   include/hw/ssi/pnv_spi.h           | 3 ++-
>>   hw/ppc/pnv.c                       | 2 ++
>>   hw/ssi/pnv_spi.c                   | 5 +++--
>>   tests/qtest/pnv-spi-seeprom-test.c | 2 +-
>>   4 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
>> index 9878d9a25f..7fc5da1f84 100644
>> --- a/include/hw/ssi/pnv_spi.h
>> +++ b/include/hw/ssi/pnv_spi.h
>> @@ -31,7 +31,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvSpi, PNV_SPI)
>>   #define PNV_SPI_REG_SIZE 8
>>   #define PNV_SPI_REGS 7
>>   
>> -#define TYPE_PNV_SPI_BUS "pnv-spi-bus"
>> +#define TYPE_PNV_SPI_BUS "pnv.spi.bus"
>>   typedef struct PnvSpi {
>>       SysBusDevice parent_obj;
>>   
>> @@ -42,6 +42,7 @@ typedef struct PnvSpi {
>>       Fifo8 rx_fifo;
>>       /* SPI object number */
>>       uint32_t        spic_num;
>> +    uint32_t        chip_id;
>>       uint8_t         transfer_len;
>>       uint8_t         responder_select;
>>       /* To verify if shift_n1 happens prior to shift_n2 */
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 11fd477b71..ce23892fdf 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -2226,6 +2226,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>>           /* pib_spic[2] connected to 25csm04 which implements 1 byte transfer */
>>           object_property_set_int(OBJECT(&chip10->pib_spic[i]), "transfer_len",
>>                                   (i == 2) ? 1 : 4, &error_fatal);
>> +        object_property_set_int(OBJECT(&chip10->pib_spic[i]), "chip-id",
>> +                                chip->chip_id, &error_fatal);
>>           if (!sysbus_realize(SYS_BUS_DEVICE(OBJECT
>>                                           (&chip10->pib_spic[i])), errp)) {
>>               return;
>> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
>> index 87eac666bb..41beb559c6 100644
>> --- a/hw/ssi/pnv_spi.c
>> +++ b/hw/ssi/pnv_spi.c
>> @@ -1116,14 +1116,15 @@ static const MemoryRegionOps pnv_spi_xscom_ops = {
>>   
>>   static const Property pnv_spi_properties[] = {
>>       DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
>> +    DEFINE_PROP_UINT32("chip-id", PnvSpi, chip_id, 0),
>>       DEFINE_PROP_UINT8("transfer_len", PnvSpi, transfer_len, 4),
>>   };
>>   
>>   static void pnv_spi_realize(DeviceState *dev, Error **errp)
>>   {
>>       PnvSpi *s = PNV_SPI(dev);
>> -    g_autofree char *name = g_strdup_printf(TYPE_PNV_SPI_BUS ".%d",
>> -                    s->spic_num);
>> +    g_autofree char *name = g_strdup_printf("chip%d." TYPE_PNV_SPI_BUS ".%d",
>> +                    s->chip_id, s->spic_num);
>>       s->ssi_bus = ssi_create_bus(dev, name);
>>       s->cs_line = g_new0(qemu_irq, 1);
>>       qdev_init_gpio_out_named(DEVICE(s), s->cs_line, "cs", 1);
>> diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
>> index 57f20af76e..ef1005a926 100644
>> --- a/tests/qtest/pnv-spi-seeprom-test.c
>> +++ b/tests/qtest/pnv-spi-seeprom-test.c
>> @@ -92,7 +92,7 @@ static void test_spi_seeprom(const void *data)
>>       qts = qtest_initf("-machine powernv10 -smp 2,cores=2,"
>>                         "threads=1 -accel tcg,thread=single -nographic "
>>                         "-blockdev node-name=pib_spic2,driver=file,"
>> -                      "filename=%s -device 25csm04,bus=pnv-spi-bus.2,cs=0,"
>> +                      "filename=%s -device 25csm04,bus=chip0.pnv.spi.bus.2,cs=0,"
>
>>                         "drive=pib_spic2", tmp_path);
>>       spi_seeprom_transaction(qts, chip);
>>       qtest_quit(qts);
--------------ep5GSil7vjuEUqVZeaJwvN9f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 27-02-2025 07:24, Nicholas Piggin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:D82UR4MO7WG9.RGLCRWPS8I29@gmail.com">
      <pre wrap="" class="moz-quote-pre">On Sat Jan 4, 2025 at 2:18 AM AEST, Chalapathi V wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Create a spi buses with distict names on each socket so that responders
are attached to correct SPI controllers.

QOM tree on a 2 socket machine:
(qemu) info qom-tree
/machine (powernv10-machine)
  /chip[0] (power10_v2.0-pnv-chip)
    /pib_spic[0] (pnv-spi)
      /chip0.pnv.spi.bus.0 (SSI)
      /xscom-spi[0] (memory-region)
  /chip[1] (power10_v2.0-pnv-chip)
    /pib_spic[0] (pnv-spi)
      /chip1.pnv.spi.bus.0 (SSI)
      /xscom-spi[0] (memory-region)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Mechanics of the patch looks fine. I don't know about the name
though.

I think "pnv-spi-bus" is the right name for the bus. Using dots as
with chip0. makes it seem like each element is part of a topology.

Would chip0.pnv-spi-bus be better?</pre>
    </blockquote>
    Will rename the bus name to <span style="white-space: pre-wrap">chip0.pnv-spi-bus . Thank You</span>
    <blockquote type="cite"
      cite="mid:D82UR4MO7WG9.RGLCRWPS8I29@gmail.com">
      <pre wrap="" class="moz-quote-pre">

I don't suppose there is a good way to create an alias so existing
cmdline works and refers to the bus on chip0? Maybe the chip0 bus
could just not have the chip0. prefix?

Thanks,
Nick
</pre>
    </blockquote>
    Would it be best to keep the chip0 prefix to have uniformity?<br>
    <blockquote type="cite"
      cite="mid:D82UR4MO7WG9.RGLCRWPS8I29@gmail.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: Chalapathi V <a class="moz-txt-link-rfc2396E" href="mailto:chalapathi.v@linux.ibm.com">&lt;chalapathi.v@linux.ibm.com&gt;</a>
---
 include/hw/ssi/pnv_spi.h           | 3 ++-
 hw/ppc/pnv.c                       | 2 ++
 hw/ssi/pnv_spi.c                   | 5 +++--
 tests/qtest/pnv-spi-seeprom-test.c | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
index 9878d9a25f..7fc5da1f84 100644
--- a/include/hw/ssi/pnv_spi.h
+++ b/include/hw/ssi/pnv_spi.h
@@ -31,7 +31,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvSpi, PNV_SPI)
 #define PNV_SPI_REG_SIZE 8
 #define PNV_SPI_REGS 7
 
-#define TYPE_PNV_SPI_BUS "pnv-spi-bus"
+#define TYPE_PNV_SPI_BUS "pnv.spi.bus"
 typedef struct PnvSpi {
     SysBusDevice parent_obj;
 
@@ -42,6 +42,7 @@ typedef struct PnvSpi {
     Fifo8 rx_fifo;
     /* SPI object number */
     uint32_t        spic_num;
+    uint32_t        chip_id;
     uint8_t         transfer_len;
     uint8_t         responder_select;
     /* To verify if shift_n1 happens prior to shift_n2 */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 11fd477b71..ce23892fdf 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2226,6 +2226,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         /* pib_spic[2] connected to 25csm04 which implements 1 byte transfer */
         object_property_set_int(OBJECT(&amp;chip10-&gt;pib_spic[i]), "transfer_len",
                                 (i == 2) ? 1 : 4, &amp;error_fatal);
+        object_property_set_int(OBJECT(&amp;chip10-&gt;pib_spic[i]), "chip-id",
+                                chip-&gt;chip_id, &amp;error_fatal);
         if (!sysbus_realize(SYS_BUS_DEVICE(OBJECT
                                         (&amp;chip10-&gt;pib_spic[i])), errp)) {
             return;
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 87eac666bb..41beb559c6 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -1116,14 +1116,15 @@ static const MemoryRegionOps pnv_spi_xscom_ops = {
 
 static const Property pnv_spi_properties[] = {
     DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
+    DEFINE_PROP_UINT32("chip-id", PnvSpi, chip_id, 0),
     DEFINE_PROP_UINT8("transfer_len", PnvSpi, transfer_len, 4),
 };
 
 static void pnv_spi_realize(DeviceState *dev, Error **errp)
 {
     PnvSpi *s = PNV_SPI(dev);
-    g_autofree char *name = g_strdup_printf(TYPE_PNV_SPI_BUS ".%d",
-                    s-&gt;spic_num);
+    g_autofree char *name = g_strdup_printf("chip%d." TYPE_PNV_SPI_BUS ".%d",
+                    s-&gt;chip_id, s-&gt;spic_num);
     s-&gt;ssi_bus = ssi_create_bus(dev, name);
     s-&gt;cs_line = g_new0(qemu_irq, 1);
     qdev_init_gpio_out_named(DEVICE(s), s-&gt;cs_line, "cs", 1);
diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
index 57f20af76e..ef1005a926 100644
--- a/tests/qtest/pnv-spi-seeprom-test.c
+++ b/tests/qtest/pnv-spi-seeprom-test.c
@@ -92,7 +92,7 @@ static void test_spi_seeprom(const void *data)
     qts = qtest_initf("-machine powernv10 -smp 2,cores=2,"
                       "threads=1 -accel tcg,thread=single -nographic "
                       "-blockdev node-name=pib_spic2,driver=file,"
-                      "filename=%s -device 25csm04,bus=pnv-spi-bus.2,cs=0,"
+                      "filename=%s -device 25csm04,bus=chip0.pnv.spi.bus.2,cs=0,"
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">                       "drive=pib_spic2", tmp_path);
     spi_seeprom_transaction(qts, chip);
     qtest_quit(qts);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------ep5GSil7vjuEUqVZeaJwvN9f--


