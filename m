Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCF0C4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 13:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3cB6-0006Fs-0j; Sun, 05 May 2024 09:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s3cB3-0006EO-6p
 for qemu-devel@nongnu.org; Sun, 05 May 2024 09:45:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s3cB0-0006w5-Fl
 for qemu-devel@nongnu.org; Sun, 05 May 2024 09:45:16 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 445Cqp3d003429
 for <qemu-devel@nongnu.org>; Sun, 5 May 2024 13:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type :
 message-id : date : subject : to : references : from : in-reply-to :
 mime-version; s=pp1; bh=7nzj4lIyk4rLya12OcZm6ZIgbaJJGfM2l6Xl29QVW04=;
 b=Z4YBdKh84FI/fKSwjM/MfM2QOzv3piN/ygZy00gjwoNGT0EQDBsAzOOKRg60kTGfbv0E
 CnVt+yliK22SVJrdUUJZmnHzkvo/gkHrHnzmAJly6iv48svn6hCgpQsGb+0GNPTo/YI/
 vilUT84OFJ4bDurPUxwyWtUVFuHCIasjcrSTwGFQNnF0/xEruPni6Qqrpn2WsLPPk7Ub
 sA5yvIRCr4MAne5QoD7Q7D1kLZu+GQy70UC4IC+x5sjPo9YI5f/lV4ja3V8hev5uq8p+
 KdelVPAN9Z0F15yRAhOa7gp0YegERangrJgltjVDTDzaA5cmxGFWYpuyQmruomD6Ol6g HA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xx4uq8qry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 13:45:11 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 445DjBjo015885
 for <qemu-devel@nongnu.org>; Sun, 5 May 2024 13:45:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xx4uq8qrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 05 May 2024 13:45:11 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 445C1HqG004724; Sun, 5 May 2024 13:45:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xx5ygs8n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 05 May 2024 13:45:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 445Dj5lE6095192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 5 May 2024 13:45:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D6C82004B;
 Sun,  5 May 2024 13:45:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C839420040;
 Sun,  5 May 2024 13:45:04 +0000 (GMT)
Received: from [9.179.21.205] (unknown [9.179.21.205])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  5 May 2024 13:45:04 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------hk90N0TSMrFnMmSOti3Pgpiv"
Message-ID: <1a1f5642-fc0e-4d1f-bc29-66da97cccd1e@linux.ibm.com>
Date: Sun, 5 May 2024 19:15:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: PCIE Memory Information
To: Muzammil Ashraf <m.muzzammilashraf@gmail.com>, qemu-devel@nongnu.org
References: <CAJHePoZ=+vJt_8CC3eYN5kjfUcqQMRjnzM+xEfoBswq8-8JWfQ@mail.gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <CAJHePoZ=+vJt_8CC3eYN5kjfUcqQMRjnzM+xEfoBswq8-8JWfQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wQWnhjOwSpMZchtS8HWaXqN0Sa5lf4xw
X-Proofpoint-GUID: RGeTpUPrxP8RNa1u2m-JxMIsq564lEmv
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_08,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405050062
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
--------------hk90N0TSMrFnMmSOti3Pgpiv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ashraf,

On 04/05/24 12:45, Muzammil Ashraf wrote:
> Hi All,
>
> I am debugging a PCI subsystem. I saw callbacks registered here to
> catch the pcie config read/write request at hw/pci/pci_host.c:201. How
> can I make my subregion to overlap this area and How to receive those
> pcie config read/write requests to my callbacks?
>
Can go through this doc: 
https://www.qemu.org/docs/master/devel/memory.html#overlapping-regions-and-priority

Normally the callbacks you mentioned will be registered on a 
MemoryRegion. You can create your own MemoryRegion, and set your custom 
.read, .write callbacks.

And setting the MemoryRegion's priority as a big positive number.


FWIW, had did something like this in past:


+static uint64_t adi_region_read(void *chip10, hwaddr addr, unsigned size) {
+ // your code
+}
+
+static void adi_region_write(void *chip10, hwaddr addr, uint64_t value, 
unsigned size) {
+ // your code
+}
+
+static const MemoryRegionOps adi_region_ops = {
+    .read = adi_region_read,
+    .write = adi_region_write,
+        .endianness = DEVICE_BIG_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+

+    static hwaddr ADI_REGION_BASE = 0x0006010000000000ull + 0x100;
+

+    memory_region_init_io(&chip10->adi_region, OBJECT(chip10), 
&adi_region_ops, chip10, "custom region: adityag", 0x100);
+    memory_region_add_subregion(get_system_memory(), ADI_REGION_BASE, 
&chip10->adi_region);

Instead of 'get_system_memory', you will have to see what is the PCI 
config region a subregion of.


Then, set the MemoryRegion's priority to some big number.

Then, you can verify if your overlapping was successful, with something 
like this:


+    MemoryRegion *mr = address_space_translate(&address_space_memory, 
ADI_REGION_BASE, &xlat, &l, false, MEMTXATTRS_UNSPECIFIED);

or

+    cpu_physical_memory_read(ADI_REGION_BASE, &val, 4);


1st should return your MemoryRegion, and second one should call your 
.read callback.


Thanks,

Aditya Gupta

--------------hk90N0TSMrFnMmSOti3Pgpiv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Ashraf,<br>
    </p>
    <div class="moz-cite-prefix">On 04/05/24 12:45, Muzammil Ashraf
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAJHePoZ=+vJt_8CC3eYN5kjfUcqQMRjnzM+xEfoBswq8-8JWfQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">Hi All,

I am debugging a PCI subsystem. I saw callbacks registered here to
catch the pcie config read/write request at hw/pci/pci_host.c:201. How
can I make my subregion to overlap this area and How to receive those
pcie config read/write requests to my callbacks?

<span style="white-space: pre-wrap">
</span></pre>
    </blockquote>
    <blockquote type="cite"
cite="mid:CAJHePoZ=+vJt_8CC3eYN5kjfUcqQMRjnzM+xEfoBswq8-8JWfQ@mail.gmail.com">
    </blockquote>
    Can go through this doc:
<a class="moz-txt-link-freetext" href="https://www.qemu.org/docs/master/devel/memory.html#overlapping-regions-and-priority">https://www.qemu.org/docs/master/devel/memory.html#overlapping-regions-and-priority</a><br>
    <p>Normally the callbacks you mentioned will be registered on a
      MemoryRegion. You can create your own MemoryRegion, and set your
      custom .read, .write callbacks.<br>
    </p>
    <p>And setting the MemoryRegion's priority as a big positive number.</p>
    <p><br>
    </p>
    <p>FWIW, had did something like this in past:<br>
    </p>
    <p><br>
    </p>
    +static uint64_t adi_region_read(void *chip10, hwaddr addr, unsigned
    size) {<br>
    + // your code<br>
    +}<br>
    +<br>
    +static void adi_region_write(void *chip10, hwaddr addr, uint64_t
    value, unsigned size) {<br>
    + // your code<br>
    +}<br>
    +<br>
    +static const MemoryRegionOps adi_region_ops = {<br>
    +    .read = adi_region_read,<br>
    +    .write = adi_region_write,<br>
    +        .endianness = DEVICE_BIG_ENDIAN,<br>
    +    .impl = {<br>
    +        .min_access_size = 4,<br>
    +        .max_access_size = 4,<br>
    +    },<br>
    +};<br>
    +<br>
    <br>
    <p>+    static hwaddr ADI_REGION_BASE = 0x0006010000000000ull +
      0x100;<br>
      +</p>
    +    memory_region_init_io(&amp;chip10-&gt;adi_region,
    OBJECT(chip10), &amp;adi_region_ops, chip10, "custom region:
    adityag", 0x100);<br>
    +    memory_region_add_subregion(get_system_memory(),
    ADI_REGION_BASE, &amp;chip10-&gt;adi_region);<br>
    <br>
    <p>Instead of 'get_system_memory', you will have to see what is the
      PCI config region a subregion of.<br>
    </p>
    <p><br>
    </p>
    <p>Then, set the MemoryRegion's priority to some big number.<br>
    </p>
    <p>Then, you can verify if your overlapping was successful, with
      something like this:<br>
    </p>
    <p><br>
    </p>
    <p>+    MemoryRegion *mr =
      address_space_translate(&amp;address_space_memory,
      ADI_REGION_BASE, &amp;xlat, &amp;l, false,
      MEMTXATTRS_UNSPECIFIED);</p>
    or<br>
    <p>+    cpu_physical_memory_read(ADI_REGION_BASE, &amp;val, 4);</p>
    <br>
    <p></p>
    <p>1st should return your MemoryRegion, and second one should call
      your .read callback.</p>
    <p><br>
    </p>
    <p>Thanks,</p>
    <p>Aditya Gupta<br>
    </p>
  </body>
</html>

--------------hk90N0TSMrFnMmSOti3Pgpiv--


