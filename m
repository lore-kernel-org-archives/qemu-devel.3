Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6423C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 20:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIZ0s-00051M-KN; Fri, 23 May 2025 16:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1uIZ0q-00050u-CL; Fri, 23 May 2025 16:29:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1uIZ0n-0007HR-JK; Fri, 23 May 2025 16:29:04 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NGWD0Y008513;
 Fri, 23 May 2025 20:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Zzl4qB
 PPs2h5UK5l5gclSK2E8S8so234C1yWL4QbPJo=; b=VpOrAZ7UQTxqqK5Xz6ZwSG
 6dmIElYCz3J8IHPXFUTY1PtmEg7BsjdvanDYYwKWFO/nZonU74B2Kcczx75F17rJ
 X2vW6VuwITQP43ceGBRVG0dYpRMK3RblNGYtzT01JmOfZI8xJFdQ/q/hrZRoP1+4
 EyIxxA6yBzShqZeX0ng75uRd5GzaXF7GJsN2PhH7YC5Q8mw6FiIw3r7WSKxT4pZM
 6kyPdgIWfLNBG0oO/gYwrVUnZxQdRLYLcCB+Dcv9Gvg0ubZjBxqPNpLaQwdME6Da
 uCq4Qc80sZmyFqZra57duxdWO250MxQF1wpIsS1UrQanC93++BHCVUuaGhQtXhxg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sxhwj14x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 20:28:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54NIFSWJ024710;
 Fri, 23 May 2025 20:28:54 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwkrgdk9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 20:28:54 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54NKSrId3998382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 20:28:53 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82D9F58063;
 Fri, 23 May 2025 20:28:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4474858055;
 Fri, 23 May 2025 20:28:52 +0000 (GMT)
Received: from [9.67.87.127] (unknown [9.67.87.127])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 23 May 2025 20:28:52 +0000 (GMT)
Message-ID: <c7d791a6-8077-4063-a587-e235e6d84850@linux.ibm.com>
Date: Fri, 23 May 2025 16:28:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/25] docs/system/s390x: Add secure IPL documentation
To: Thomas Huth <thuth@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com
Cc: jjherne@linux.ibm.com, jrossi@linux.ibm.com, fiuczy@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-26-zycai@linux.ibm.com>
 <4e170da7-3ffd-4edb-8695-a3abc9333c75@redhat.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <4e170da7-3ffd-4edb-8695-a3abc9333c75@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE4NCBTYWx0ZWRfX+Q0z5xRyeHKN
 SYcpLsBjKjP3oQo9iBEXizLrCv6ZaXSDclICsfqXKccCc2adi98Whx513gYh419HtwPsGEa4sZ4
 6yzgo1NGRzaTI4mAEHRB4nBpk6IIZC7tS+AxyNwpypdwM3QKuhKTjPLZTJDSt4KEZNdz54LCTjf
 dc01qG7KHkEvyw3F+n4TYtIwz6Ug4UZKzZT3iY6DsRKU/iJQ2dAm2s74iUtfFTZlh4vO9iawYny
 TCYNJ8E3sCc2MqsTI/ksjmRLhu935dDNxmcMIZ5DqUUDjteRGyt2HW5iRxT+9fozECQ4NeuAbhN
 gi1n+em6uKF5r6/V90LUwNbNT7mB3KuVLHkK3jrGIDWdyqvyzWGeWBdlehLR+SW7aLdDnr3f2/e
 6JVlvCUqGG/69XKxsfDAlGJmh0QrNQVWvXe2T1BIg++hibRg7ByaJAh+KGVvHvpDDqIPVNqM
X-Proofpoint-GUID: CWOMvmiKQY-eyxtQ5v7skX7agv-TLtzD
X-Authority-Analysis: v=2.4 cv=O685vA9W c=1 sm=1 tr=0 ts=6830da88 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=v3B5DFozSApZRYLVjaUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CWOMvmiKQY-eyxtQ5v7skX7agv-TLtzD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230184
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/21/25 8:37 AM, Thomas Huth wrote:
> On 09/05/2025 00.50, Zhuoying Cai wrote:
>> Add documentation for secure IPL.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   docs/system/s390x/secure-ipl.rst | 249 +++++++++++++++++++++++++++++++
>>   1 file changed, 249 insertions(+)
>>   create mode 100644 docs/system/s390x/secure-ipl.rst
>>
>> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
>> new file mode 100644
>> index 0000000000..4f80d7741e
>> --- /dev/null
>> +++ b/docs/system/s390x/secure-ipl.rst
>> @@ -0,0 +1,249 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +s390 Secure IPL
>> +===============
>> +
>> +Secure IPL, also known as secure boot, enables s390-ccw virtual machines to
>> +leverage qcrypto libraries and z/Arch implementations to verify the integrity of
>> +guest kernels. These operations are rely on userspace invocations and QEMU
>> +interpretation.
> 
> I don't understand the last sentence. Could you please rephrase it?

It's my poorly worded phrasing to say "userspace and QEMU must work in
tandem to complete the secure IPL operations".  Basically encapsulating
the bulleted list below.

"Interpretation" was a poor choice -- should have said "QEMU handling"
or something akin to that.  Will revisit when splitting this into specs
and doc.

> 
>> The user provides one or more certificates via the command line
>> +options, which populates a certificate store. DIAGNOSE 'X'320' is invoked by
>> +userspace to query cert store info and retrieve specific certificates from QEMU.
>> +DIAGNOSE 'X'508' is used by userspace to leverage qcrypto libraries to perform
>> +signature-verification in QEMU. Lastly, userspace generates and appends an
>> +IPL Information Report Block (IIRB) at the end of the IPL Parameter Block.
>> +
>> +The steps are as follows:
>> +
>> +- Userspace retrieves data payload from disk (e.g. stage3 boot loader, kernel)
>> +- Userspace checks the validity of the SCLAB
>> +- Userspace invokes DIAG 508 subcode 1 and provides it the payload
>> +- QEMU handles DIAG 508 request by reading the payload and retrieving the
>> +  certificate store
>> +- QEMU DIAG 508 utilizes qcrypto libraries to perform signature-verification on
>> +  the payload, attempting with each cert in the store (until success or
>> +  exhausted)
>> +- QEMU DIAG 508 returns:
>> +
>> +  - success: index of cert used to verify payload
>> +  - failure: error code
> 
> So this doc is rather meant as a specification, not as a documentation for 
> the end user? In that case it should maybe rather reside in docs/specs/ and 
> not in docs/system/s390x.
> 
>> +- Userspace responds to this operation:
>> +
>> +  - success: retrieves cert from store via DIAG 320 using returned index
>> +  - failure: reports with warning (audit mode), aborts with error (secure mode)
>> +
>> +- Userspace appends IIRB at the end of the IPLB
>> +- Userspace kicks off IPL
>> +
>> +
>> +Constraints
>> +-----------
>> +
>> +The following constraints apply when attempting to secure IPL an s390 guest:
>> +
>> +- z16 CPU model
>> +- certificates must be in X.509 DER format
>> +- only sha256 encryption is supported
>> +- only support for SCSI scheme of virtio-blk/virtio-scsi devices
>> +- a boot device must be specified
>> +- any unsupported devices (e.g., ECKD and VFIO) or non-eligible devices (e.g.,
>> +  Net) will cause the entire boot process terminating early with an error
>> +  logged to the console.
>> +
>> +
>> +s390 Certificate Store
>> +======================
>> +
>> +Secure boot relies on user certificates for signature-verification. Normally,
>> +these certificates would be stored somewhere on the LPAR. Instead, for virtual
>> +guests, a certificate store is implemented within QEMU. This store will read
>> +any certificates provided by the user via command-line, which are expected to
>> +be stored somewhere on the host file system. Once these certificates are
>> +stored, they are ready to be queried/requested by DIAGNOSE 'X'320' or used for
>> +verification by DIAGNOSE 'X'508'.
>> +
>> +The certificate store can be populated by supplying a comma-delimited list of
>> +certificates on the command-line:
>> +
>> +.. code-block:: shell
>> +
>> +    qemu-system-s390x -machine s390-ccw-virtio, \
>> +    boot-certificates=/.../qemu/certs:/another/path/cert.der
>> +
>> +
>> +DIAGNOSE function code 'X'320' - Certificate Store Facility
>> +-----------------------------------------------------------
>> +
>> +DIAGNOSE 'X'320' is used to provide support to query the certificate store.
>> +
>> +Subcode 0 - query installed subcodes
>> +    Returns a 256-bit installed subcodes mask (ISM) stored in the installed
>> +    subcodes block (ISB). This mask indicates which sucodes are currently
>> +    installed and available for use.
>> +
>> +Subcode 1 - query verification certificate storage information
>> +    Provides the information required to determine the amount of memory needed to
>> +    store one or more verification-certificates (VCs) from the certificate store (CS).
>> +
>> +    Upon successful completion, this subcode returns various storage size values for
>> +    verification-certificate blocks (VCBs).
>> +
>> +    The output is returned in the verification-certificate-storage-size block (VCSSB).
>> +
>> +Subcode 2 - store verification certificates
>> +    Provides VCs that are in the certificate store.
>> +
>> +    The output is provided in a VCB, which includes a common header followed by zero
>> +    or more verification-certificate entries (VCEs).
>> +
>> +    The first-VC index and last-VC index fields of VCB specify the range of VCs
>> +    to be stored by subcode 2. Stored count and remained count fields specify the
>> +    number of VCs stored and could not be stored in the VCB due to insufficient
>> +    storage specified in the VCB input length field.
>> +
>> +    VCE contains various information of a VC from the CS.
>> +
>> +
>> +IPL Modes
>> +=========
>> +
>> +Different IPL modes may be toggled with the following command line option:
>> +
>> +.. code-block:: shell
>> +
>> +    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on|off
>> +
>> +Additionally, the provision of certificates affect the mode.
>> +
>> +
>> +Normal Mode
>> +-----------
>> +
>> +The absence of both certificates and the ``secure-boot`` option will attempt to
>> +IPL a guest without secure IPL operations. No checks are performed, and no
>> +warnings/errors are reported.  This is the default mode, and can be explicitly
>> +enabled with ``secure-boot=off``.
>> +
>> +
>> +Audit Mode
>> +----------
>> +
>> +With *only* the presence of certificates in the store, it is assumed that secure
>> +boot operations should be performed with errors reported as warnings. As such,
>> +the secure IPL operations will be performed, and any errors that stem from these
>> +operations will report a warning via the SCLP console.
>> +
>> +
>> +Secure Mode
>> +-----------
>> +
>> +With *both* the presence of certificates in the store and the ``secure-boot=on``
>> +option, it is understood that secure boot should be performed with errors
>> +reported and boot will abort.
>> +
>> +
>> +Secure IPL Functions
>> +====================
>> +
>> +IPL Information Report Block
>> +----------------------------
>> +
>> +The IPL Parameter Block (IPLPB), utilized for IPL operation, is extended with an
>> +IPL Information Report Block (IIRB), which contains the results from secure IPL
>> +operations such as:
>> +
>> +* component data
>> +* verification results
>> +* certificate data
>> +
>> +
>> +Secure Code Loading Attributes Facility
>> +---------------------------------
>> +
>> +Secure Code Loading Attributes Facility (SCLAF) provides additional security during IPL.
>> +
>> +When SCLAF is available, its behavior depends on the IPL Modes.
>> +
>> +* secure mode: IPL will terminate on any errors detected by this facility.
>> +* audit mode:  IPL may proceed regardless of any errors detected by this facility.
>> +
>> +Errors detected by the SCLAF are reported in IIRB.
>> +
>> +Unsigned components may only be loaded at absolute storage address x’2000’ or higher.
>> +
>> +Signed components must include a Secure Code Loading Attribute Block (SCLAB),
>> +which is located at the very end of the signed component.
>> +
>> +**Secure Code Loading Attribute Block (SCLAB)**
>> +
>> +The SCLAB is located at the end of each signed component. It defines the code loading
>> +attributes for the component and may:
>> +
>> +* Provide direction on how to process the rest of the component.
>> +
>> +* Provide further validation of information on where to load the signed binary code
>> +  from the load device.
>> +
>> +* Specify where to start the execution of the loaded OS code.
>> +
>> +
>> +DIAGNOSE function code 'X'508' - KVM IPL extensions
>> +---------------------------------------------------
>> +
>> +DIAGNOSE 'X'508' is reserved for KVM guest use in order to facilitate
>> +communication of additional IPL operations that cannot be handled by userspace,
>> +such as signature verification for secure IPL.
>> +
>> +If the function code specifies 0x508, KVM IPL extension functions are performed.
>> +These functions are meant to provide extended functionality for s390 guest boot
>> +that requires assistance from QEMU.
>> +
>> +Subcode 0 - query installed subcodes
>> +    Returns a 64-bit mask indicating which subcodes are supported.
>> +
>> +Subcode 1 - perform signature verification
>> +    Used to perform signature-verification on a signed component, leveraging
>> +    qcrypto libraries to perform this operation and pulling from the certificate
>> +    store.
>> +
>> +
>> +Secure IPL Quickstart
>> +=====================
>> +
>> +Build QEMU with gnutls enabled:
>> +
>> +.. code-block:: shell
>> +
>> +    ./configure … --enable-gnutls
>> +
>> +Generate certificate (e.g. via openssl):
>> +
>> +.. code-block:: shell
>> +
>> +    openssl req -new -x509 -newkey rsa:2048 -keyout mykey.priv \
>> +                -outform DER -out mycert.der -days 36500 \
>> +                -subj "/CN=My Name/" -nodes
>> +
>> +Sign Images (e.g. via sign-file):
>> +
>> +- signing must be performed on a KVM guest filesystem
>> +- sign-file script used in the example below is located within the kernel source
>> +  repo
>> +
>> +.. code-block:: shell
>> +
>> +    ./sign-file sha256 mykey.priv mycert.der /boot/vmlinuz-…
>> +    ./sign-file sha256 mykey.priv mycert.der /usr/lib/s390-tools/stage3.bin
>> +
>> +Run zipl with secure boot enabled
>> +
>> +.. code-block:: shell
>> +
>> +    zipl --secure 1 -V
>> +
>> +Start Guest with Cmd Options:
>> +
>> +.. code-block:: shell
>> +
>> +    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certificates=mycert.der ...
> 
> So that quickstart section looks like it could be useful for the end user? 
> Maybe you could split your doc up into two part, one going into 
> docs/system/s390x/ for the normal users, and one going into docs/specs/ as 
> technical reference for the developers?
> 
>   Thomas
> 
> 

Sure.  So, for the specs we can include the following sections:
 - s390 Secure IPL
 - s390 Certificate Store (description)
 - DIAG 320 and 508
 - Secure IPL Functions (and all sub sections)

For the docs:
 - Constraints
 - s390 Certificate Store (command line), probably rename this section
 - IPL Modes
 - Quickstart

-- 
Regards,
  Collin

