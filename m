Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491C3C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 12:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH0uF-0006EB-Jd; Tue, 11 Jun 2024 08:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1sH0uD-0006E0-S5
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:47:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1sH0u9-0003US-F9
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:47:17 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BBMW9K015246;
 Tue, 11 Jun 2024 12:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PU9kOPwr79YmCjx73VzEASj54I2rRUXn9CHo5kZqH9w=; b=dq8hubu8rt6KBdbk
 50JxWkvmVsrte+tX4el+NJtANSKlPjvV0zpSTGfQkhnGchxLiLRkwKA1Y+apX4E8
 cxA9GB7gIAryNMyt4DQ5vTB0LyNvFATGcgKWRvDWXm6xZvVKK9lQRBzlAOULwPed
 nHc1PZvHe9LE+crSG9MBJe4lXueL7BUA37cabtw2iDJERkhdETu8IOnRF6cAK7nM
 mIt68bFBsq7WgvH+ar6x6jcl8v3c1oZtM915eOQEEoWqyB3zIeSb0q44oLUPv3Zk
 epJYTrC24c8lDaL9SX6y6L/lmfA/+59iehbGjZ+QJ+TIsQ9V0tIIicqg7W6Cx3kJ
 h9peeg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfh377ms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Jun 2024 12:47:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 45BCl6Vr012245
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Jun 2024 12:47:06 GMT
Received: from [10.111.129.48] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 05:47:02 -0700
Message-ID: <e76ba00c-0b9c-42ad-93e2-13a2e6662c60@quicinc.com>
Date: Tue, 11 Jun 2024 14:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
CC: Pierrick Bouvier <pierrick.bouvier@linaro.org>, <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <d910708f-ed55-4eee-8f66-8703cb45081c@linaro.org>
 <evt7n.ggoypj31l14q@linaro.org> <ZmgtfgqOOKeipIDd@redhat.com>
 <ewxal.5kz7id1gqls@linaro.org>
Content-Language: en-US
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <ewxal.5kz7id1gqls@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: w63uAyW-qA-7gsXlRZ3pbZ5lFEyDQQEZ
X-Proofpoint-GUID: w63uAyW-qA-7gsXlRZ3pbZ5lFEyDQQEZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_07,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110093
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi there :)

On 11/06/2024 12:58, Manos Pitsidianakis wrote:
> On Tue, 11 Jun 2024 13:57, "Daniel P. Berrangé" <berrange@redhat.com> 
> wrote:
>> On Mon, Jun 10, 2024 at 11:29:36PM +0300, Manos Pitsidianakis wrote:
>>> On Mon, 10 Jun 2024 22:37, Pierrick Bouvier 
>>> <pierrick.bouvier@linaro.org> wrote:
>>> > Hello Manos,
>>> > > On 6/10/24 11:22, Manos Pitsidianakis wrote:
>>> > > Hello everyone,
>>> > > > > This is an early draft of my work on implementing a very 
>>> simple device,
>>> > > in this case the ARM PL011 (which in C code resides in 
>>> hw/char/pl011.c
>>> > > and is used in hw/arm/virt.c).
>>> > > > > The device is functional, with copied logic from the C code 
>>> but with
>>> > > effort not to make a direct C to Rust translation. In other 
>>> words, do
>>> > > not write Rust as a C developer would.
>>> > > > > That goal is not complete but a best-effort case. To give a 
>>> specific
>>> > > example, register values are typed but interrupt bit flags are 
>>> not (but
>>> > > could be). I will leave such minutiae for later iterations.
>>
>> snip
>>
>>> > Maybe it could be better if build.rs file was *not* needed for new
>>> > devices/folders, and could be abstracted as a detail of the python
>>> > wrapper script instead of something that should be committed.
>>>
>>>
>>> That'd mean you cannot work on the rust files with a LanguageServer, you
>>> cannot run cargo build or cargo check or cargo clippy, etc. That's why I
>>> left the alternative choice of including a manually generated 
>>> bindings file
>>> (generated.rs.inc)
>>
>> I would not expect QEMU developers to be running 'cargo <anything>'
>> directly at all.
>>
>> QEMU's build system is 'meson' + 'ninja' with a 'configure' + 'make'
>> convenience facade.
>>
>> Any use of 'cargo' would be an internal impl detail of meson rules
>> for building rust code, and developers should still exclusively work
>> with 'make' or 'ninja' to run builds & tests.
> 
> No, that's not true. If I wrote the pl011 device with this workflow I'd 
> just waste time using meson. Part of the development is making sure the 
> library type checks, compiles, using cargo to run style formatting, to 
> check for lints, perhaps run tests. Doing this only through meson is an 
> unnecessary complication.
> 

My favorite tool for Rust development is rust-analyzer, which works very 
well with cargo-based projects. Making it work with meson is just a 
matter of pointing rust-analyzer to the rust-project.json file generated 
by meson at configuration time (just like compile_commands.json).

Unfortunately, rust-analyzer also relies on cargo for doing its check. I 
was able to override that with ninja, but it requires `meson setup` with 
`RUSTFLAGS="--emit=metadata --error-format=json"`. That makes 
rust-analyzer happy, but compilation output is not readable anymore 
being json-like.

I ended up working with 2 build folders, one for me, one for 
rust-analyzer. So, yeah, it complicates a bit.

> To compile and run QEMU with a rust component, sure, you'd use meson.
> 

Cheers,
Antonio

