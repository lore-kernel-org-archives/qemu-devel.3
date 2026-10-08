Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4084FCA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEqeA-0003Nk-LH; Thu, 08 Oct 2026 12:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEqdy-0003MQ-Uf
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 12:06:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEqdw-0004Bh-PO
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 12:06:54 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EW2TW2535818
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 16:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RNpKEGqC+iS1pxEUCOoxwofSGXLA9+Mw8F3MzfNYBNs=; b=SPEsPxypNFmnvR+p
 tl7dyBAEdKteIajPoRhjdNUfXqOzrOLz6PEDNh4dyy2qUfz8xl+Et2eu6d/eK4kq
 C7+qQVd9HHQgDcvIh5pxeuVwhIJmS+AxknjIVFeVvz3NQh+aQ1X8nZszKxk/5i0E
 LRuXQO/e//U0pyZok3Sq6ZSfm6fCnxiC3iyrx848DX/KqVR3b3s8J+JS1r7cArYX
 ty86r3eTZLgfyS9jnnoQA5Nafp3UWBpMbTKHe7AVjXFlV0IkxgIBuJrQ5VOlKBu1
 DYEIwp1aP/+2DLK6jETFUw1vQFoPIBT0PpsBY8BHWP5cwbKw/tOYIL4avx+SnVKx
 G6GpFQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe53ph4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 16:06:50 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3517ee4b01cso746238eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791475609; x=1792080409; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RNpKEGqC+iS1pxEUCOoxwofSGXLA9+Mw8F3MzfNYBNs=;
 b=khjzcqbS9kfqs+W00RGzJmOnkG+udTwbcnYo8s7oWwKhY9VD/Eu4IR24mRWIDaE8yN
 a2iEN19eiwO1AA9ayQ5fDlgV8ZqelpEx0IznktQSzRxssi2LlrJLvU1yN8dRTVfKwPuq
 Jp4s80o44pTicpEZ5jnwmqZYwy+AiDkga7zMzjzWToDS1IdVQUjKQeuZeH54xfadXor4
 +1KjGZiD+hEMmPXRKlmtNj39v3fWR+q/2bfr+yqkHFzftD/EXoEYgYb7MpVP3iC18msC
 aRIpTGGdBNjRGixTLFjTnDlKtWwow7L1UKjd0hDEaDZm0YG9eu1jR5VFSp/BeoVRHXk2
 Cu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791475609; x=1792080409;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RNpKEGqC+iS1pxEUCOoxwofSGXLA9+Mw8F3MzfNYBNs=;
 b=EopwDOCR7PokD9eT4O9HFlk4aD0D+87cvEw7HPgV7Pso4OwFPVUc8suEBhEDM4GLoV
 ZQTpxpvhDr50TPsWb7eK5+k8ktSS1QJBivFfQsmvkVgy3M1DtYjQ10ndEZrjzW/eWFL6
 FEIyFWX3/yN36HgzWRgRzbvCaBEghk09DIWVgmep0zFD4lJezLcdCoQp+oGhPgkqTfCn
 GdTu7FwGil69f2KXNGDWL5uWQz00S4nddtSU59ZK3XEGnIVnHb3NqVPQWGUeQCbwI2y9
 8q4/pXaFjCmA6G8yOl6sVUPWjYmJf57CNJ0s2E/l+upgUAX/TZxO27hhpKDKUscx1zHw
 l1XQ==
X-Gm-Message-State: AFq9FYISDfVNZ/YukhF0SuqX6rDDIxBxxUuvDthJe8Tzx0ngdZno2xPM
 TMaFTA1ke4ysuALPNd89R6wyYDxjS3WNkeRH3iYuSFx/M1jlfHG5LeKCsoLybJvUpjosh8700KX
 l3DWkHU5rCj5lS0FcmIkoWcIfYQi9hYkJRsdmxqXA+8evAPcim2IvZonOzQ==
X-Gm-Gg: AYBFou0g5E2M0ZkoIeGWhgM1KinjWTy1E8BQbGxBzWsi7PTEIwxc9H0hJfbhsV0aRtE
 ATsY6z8pPceXvcq1t93h94ozeljhRykgQL3iBFNMJyJ5rqzwI8kUnIdpySGctgj26ZYXi0kzeda
 pI5hwEwycE79J2bCCzlHLWoZJ6FaibZdghsof6sr6Iie9G4DMLKYUEOZ4LhIMHOR15aKsrAcJ2s
 E/ruuzrIaIG4GM7sTIJ9jLFmZTyOSQXT5L1FwSYPLNZhu11P071kYkmR/qL1imD5oRbfPs2MZgg
 CEKyNDTgUvM2hZO6Zlh+0Ql6Zd+rwb/Lna4u2g1LBH0dkuV14/L9yFv3dKBAuIzR/haK2RAoyI+
 W0FByW0EsevIdoq7Vc5ss5429FrOi3pfPv3A7KEHavPDi2mfExMOtCFIx6f1Y4Nlsf4uC/g==
X-Received: by 2002:a05:7300:ae97:b0:34b:6f6c:2274 with SMTP id
 5a478bee46e88-35177712b36mr3550370eec.5.1791475609092; 
 Thu, 08 Oct 2026 09:06:49 -0700 (PDT)
X-Received: by 2002:a05:7300:ae97:b0:34b:6f6c:2274 with SMTP id
 5a478bee46e88-35177712b36mr3550333eec.5.1791475608438; 
 Thu, 08 Oct 2026 09:06:48 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3535c449424sm414121eec.18.2026.10.08.09.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 09:06:47 -0700 (PDT)
Message-ID: <42fd67c0-c20d-4bc4-bede-79073e4be4a1@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 09:06:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] qom: pass TargetInfo to the is_available callback
To: luoyonggang@gmail.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <2390b3d7-6918-41e3-8532-c19de4cdd1ff@oss.qualcomm.com>
 <asdlbOZBSYIaCMIh@redhat.com>
 <CAE2XoE91XxoJRFpQ_1jhmX6LdxMyN16CF7RXxM62C5Ctkc1tig@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE91XxoJRFpQ_1jhmX6LdxMyN16CF7RXxM62C5Ctkc1tig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _NvDv4C0fuMl5dCkiLH2peRd60ILecmO
X-Authority-Analysis: v=2.4 cv=E4dYNqdl c=1 sm=1 tr=0 ts=6ac7bf9a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=E2OFlpCjAAAA:8 a=vqL-DJG3AAAA:8
 a=SqMvC5kiAAAA:8 a=J7Vs0gARAAAA:8 a=iXcLlBOuAAAA:8 a=QdPn6uz0oVhVYk1a3-cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=l0t8tTNIJzRGstKQVvrs:22 a=N5whb6oI2XAsh5LpMrx1:22 a=_o8VnCo6Hb5Oqlm6Mk7M:22
 a=GK7RtA2AnwkbbjW1WRsD:22 a=U82d2PgYpd_3u6iqMSvn:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2NCBTYWx0ZWRfX0AtmGmgcKxK8
 B3Ve65PlDVy0P+NqjA5LT/NZoYc2S4JPTn1ciLaApwXXSOgHkA9eLOmXTghdmrllJuMLOKaWMoj
 GU6vlzjQZBGAxuKocZZZenpsnpnigBk=
X-Proofpoint-GUID: _NvDv4C0fuMl5dCkiLH2peRd60ILecmO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2NCBTYWx0ZWRfX6VqNWHX+YViJ
 RysFmEEIjw/uvdQ+9OTNqCGcrI6KEr0FjsLOVcauqNLJstBTHbv5XiVVwo2TVSUq0JLHD9JdZXp
 FgF02RwyBP0HLe23X9IQ1dxbg/44SZG5nhPxmK/rlnJF8JHLbfOudcnC7heJ1iXAT4/aobnYBRZ
 1Pi6FPTRP64FsGzhIjhgGoyClSJYMno2rMNGlBHkDdpX3NysZtwAx93nJFrw7g/0jy9XOsRU/EX
 9tTQv7ayalwPLyNzouSezES1/gCY2asiS+Tj6cFl9grbOR/riKaLzIVQof2GH1OOeRS7tJoCigN
 5nnQiGo509ciIdjObdgUS6Y1mzLQz3yVEgCbfvSBMJKvRhDmeQXy532yFazGO99f3ES6zoJoSt4
 cYO0nGAMZJgp964/nYaM6f8gNCGKYnCd6sF3uISLZ/gofYKZjZEs1WeGqGoaScSSvi4jiWZF5Ml
 vCDA4t/G3Z/PUi/Urhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080064
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/8/2026 2:46 AM, Yonggang Luo wrote:
> On Thu, Oct 8, 2026 at 5:42 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Wed, Oct 07, 2026 at 01:25:46PM -0700, Pierrick Bouvier wrote:
>>> On 10/7/2026 4:47 AM, Yonggang Luo wrote:
>>>> This allows a combined binary to register machine types from all its targets.
>>>> Consequently, QMP `query-machines` can return machine entries from every
>>>> target, even when `none` is selected. For example, a client can query the
>>>> combined machine list with:
>>>>
>>>> ```json
>>>> { "execute": "query-machines" }
>>>> ```
>>>>
>>>> The returned list includes the registered machine classes from all linked
>>>> targets. This is separate from selecting a machine: with `-target none`,
>>>> `-M virt` reports the targets that provide `virt` instead of choosing one
>>>> arbitrarily:
>>>>
>>>> ```text
>>>> qemu-system -target none -M virt
>>>> unsupported machine type: "virt" for target "none"
>>>> Available for targets:
>>>>   aarch64
>>>>   arm
>>>> ```
>>>>
>>>
>>> From the long conversation on a previous thread, I thought we reached
>>> the conclusion that if we didn't expose any ambiguous name, then -target
>>> option is unnecessary, or maybe I got lost on track of this thread.
>>>
>>> https://lore.kernel.org/qemu-devel/ar_coT44h5-zJPVV@redhat.com/
>>>
>>> I'm not sure which semantic we want to have with -target none. If there
>>> is no ambiguous name registered, we just don't need it at all. It's a
>>> win-win IMHO.
>>
>> Yes, if we expose unique names for every machine, then -target is then
>> redundant.
> 
> so how to diff riscv32-virt and risv64-virt? oh so for this machine we
> needs two name?
> "virt" needs register twice for it? or register only a single time,
> but we prefix the target_name()
> automatically? for example machine::name === "virt", but we can use
> "riscv32-virt" "risv64-virt" to reach it?
>

Yes, ideally we should have different variant of virt for 32/64 bit.
Same goes for cpu max types.

QOM type is always registered unambiguously ("$arch-virt"). Then, for
the "alias" name, which is virt, in case multiple matches are found,
command line can return an error with list of unambiguous names to call it.

$ qemu-system -M virt
Multiple virt machines are available. Please choose one of them:
- aarch64-virt
- riscv64-virt

There is no "parsing" of the argument, it's just the real QOM type. Then
we can find which target it implements from mc->targets.
And then, we can automatically choose which cpus should be available
based on that, thanks to cpu->targets.

For existing binaries, nothing change.

>>
>> With regards,
>> Daniel
>> --
>> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
>> |: https://libvirt.org          ~~          https://entangle-photo.org :|
>> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>>
> 
> 


