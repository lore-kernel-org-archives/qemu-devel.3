Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82736C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0ysY-0006cH-Q1; Mon, 31 Aug 2026 06:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0ysX-0006ZB-62
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:04:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0ysV-0001tk-H6
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:04:36 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xZW22924382
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 10:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fUBo6xidHc+IM+BTVd0Bbr4FdBSolOTLMl94iGaA8Sg=; b=JOxnIc68qb2RuWD6
 Q94AVb0bgfakM001u25hH212Y7UHOMczrjqPBJ3lsVlHj0ClYFFkVfKSoLSHoPF6
 +e2o7gA4TM9P/F+uWMbL36B4cQf5eZvsx0hjeKj58Y6SdVJI05WuY4oKXhhiVVix
 AuVtXSC2aSp0n6duO+DXd1EKT1VSVxyJASSSgJv5Y9hDTx9ybmvC6ACYSOZP75SS
 5gbD7TXpWAtYqVU4p0cTlRgGnUR5kD1bT7hrQVKABB9xELXkcH3RF5HNUde7HNUl
 5/PGYypJ5QvnL9MtFu5jzFyX7btgtvbO4NrwO6fKvvOHi8z6X7BO/sgIFW8OxYZV
 npzoaw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv7wa4hn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 10:04:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e538afe65so785310085a.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 03:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788170673; x=1788775473; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fUBo6xidHc+IM+BTVd0Bbr4FdBSolOTLMl94iGaA8Sg=;
 b=j1o0eICKXrTzF5RgQnrBUuRhDyQbAsPa4773BCkj+8yt5d6r5yrW7X8o4bHEQTJJM5
 bKb0Rh0HtgCXBOTFQ7eAvSWfq8nxsP4/sz+Lexecv06VBTXGyhBT/JpAIdTVIfP16nPV
 p65GmIw98GZhUOVJAKAYOJuahm1jrx43G9/Uogn6nfXE1km9NoM3ABnMzZr/ZKHWx4EK
 woMvP5GOe5u49Gu7bWQ7bHOtquVaqrjdmUVIZxoNUelXsTowQ9YheXpmbQK3cpHlgKO7
 mxF5Zb3ADpF7Gnqg3irS4vPWAJB3MiQ0udYVc47WfO0suvk/lOhpp6TzNGtV7o31D/o1
 Fn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788170673; x=1788775473;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fUBo6xidHc+IM+BTVd0Bbr4FdBSolOTLMl94iGaA8Sg=;
 b=LRBzY/hogBOOv2ATrwlEJ7WB4yuFIf+TWBBPe84oph53CrU75J5rBlp6XLBhaqv5BY
 JX5LxG7ZNXjArXAoNkPMMTNzVfyWMT1Pu89YcBaQscvY89o5YjmT6urKhccuVoOYRLbb
 usYcKanoE3Qh9T4T7hajLt2AlGibptsszNqdJQdn8yasEKxNmcJJCuLvZkoD0BEzEskw
 XNTEGHqW1wFjK6J4OkxGP5Yj+NpPG55pjLL+HbkCtk+wqDSc2ytKj1MhwFmoN1DkBDmu
 yiNuQjrTmoUo68IF5YAY4WqNeT6yF3mkpVu1w8Jqg+GZ9oNaRf74FT/MorB8lAcpz8om
 VTDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZ2RA+6rU80gtPLglaW019gW3LrgnJbGedkjkc4hEOxIyLmVArVzgv/oAZpZXBt69+YmjNXEyPMhAy@nongnu.org
X-Gm-Message-State: AFuF++klr0aRdlx+SppIqClLygKk6RssBAh7cy87cDLSh3o4qWwowBeG
 lI/AoACRtOeunMDtFaVSmocSbeHpGtRhVAXEmOpcl7ryLkUa53cxzOHLv9n+wIGgNAK7scBRLpi
 lVDaYVQmDMCyJUTxhq/YPfEPfWxSgp00S1hYgKj3sdc1Ga0Sr/7267sP9zQ==
X-Gm-Gg: AR+sD11n/uoM24w4WD0KZqTysAoZ3TETFNCHmnnLEGHzkPktbPTvElI4Y8K9j9Zh6uA
 QrPJVrDnnLjMlgT8NYZ9BLJgPc26OCPCOOGtIVz4MQuXj1l+ApF5gPNPHA7EY2YFMuQbriu/cby
 YtDQD3S4lwvb2IeZJAIxfDrItApSJiRq1B+CDk3xCL9OpP41gS68RU+iAJeoMHup74y0OHhxqSD
 TbJeGvlF9cRbNH1XTZtWjpngiww97qS/L4846PdpgSBEO9tSKwTV3u9GLkyZBmHrxvaM7EhqOIc
 SvKySDPdJe2dB3em5XCYpcSKVukK4L86ld7SKxwe8yHX67JlXBV43CwnPX26NgvVy4Rv5QU2A3c
 vpnka2QIiDawvoWd81/NFnBRaC9Yc5TbXFw==
X-Received: by 2002:a05:620a:4416:b0:939:16f5:94cf with SMTP id
 af79cd13be357-93942b473bdmr171000985a.22.1788170673579; 
 Mon, 31 Aug 2026 03:04:33 -0700 (PDT)
X-Received: by 2002:a05:620a:4416:b0:939:16f5:94cf with SMTP id
 af79cd13be357-93942b473bdmr170992585a.22.1788170673155; 
 Mon, 31 Aug 2026 03:04:33 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20793sm21222048f8f.17.2026.08.31.03.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 03:04:24 -0700 (PDT)
Message-ID: <4a1dc959-98f9-4be8-a842-badd4622a890@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 12:04:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] hw/usb/aspeed-udc: Add ASPEED UDC gadget USB device
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260831092125.1022201-1-jamin_lin@aspeedtech.com>
 <20260831092125.1022201-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260831092125.1022201-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a9551b2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=fsNtAQk0wgLITp3n_WMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4NiBTYWx0ZWRfXxCR8BIiWv6c9
 avSJ3U2LpNoEvXwdj1LB6JVBcrykfoD6pv2y0rRdFSKUXhCMqewsKKh6/nxhMZNThflrsYh1Pwc
 fSL7t7o7Rb2ZwE9Ny8rnmlQw3+GvvHU=
X-Proofpoint-ORIG-GUID: ya0RNHlyBp-8G89HOL1C6MK06y8Hd0xz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4NiBTYWx0ZWRfX4kRBw/gvY773
 qODjoYcZu7dwT9daztuJ8aYp7LAGQJW6lwKJI928gSrTjJUAmlPtemZTvuV5403VNW+4jWXzOzG
 H3vuYrq/xdt//pQDDRzxhc+vN65xj5Rmu6F1kIC8JSpELCfHAyBG7gVP0nvQaDe3hxMB9+AJjhf
 Mev8MirfuV/790B1WzQ2AhZAWnp/Lq8Qilp2kWjsioXDEUu23vzE0Bq1/5AmtBY1STSMs/Bnmqf
 FxhL9MTsH3A9kAhrUhR9C6Rob/kAG8nYTLgt1MT1sMA/ClSDH5cPBxRnqo0KxBRrpMbCio8hM9o
 EpTwKzRFmQFfIYgC026/93GyZ5hxu4uQzoLKdGdGb9+U0WFWffOFPUXeTvQjMicM1xNynSfpnmM
 uOV8dy5vVNz1rdInJe4nDKK+lMpuE7qfh+QirtK9tJkYnIFcZtIIxPndyhImZ5z0gW6A/aUiEGC
 a4AGUvl3itz11bvKm3w==
X-Proofpoint-GUID: ya0RNHlyBp-8G89HOL1C6MK06y8Hd0xz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310086
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 31/8/26 11:21, Jamin Lin wrote:
> Present the UDC gadget side to a USB host controller as a USB device
> (TYPE_ASPEED_UDC_GADGET). This is a normal QEMU USB device, so it can be
> attached to any USB host controller bus, not only the BMC's own EHCI. It
> links back to its controller through the "udc" property.
> 
> This patch implements the control endpoint (EP0), which is enough for the
> host to enumerate the gadget. Host control transfers are handled
> asynchronously: the SETUP packet is mirrored into the SETUP data buffer,
> the EP0 interrupt is raised and the host packet is parked (USB_RET_ASYNC).
> The guest gadget driver then drives the data and status stages by writing
> UDC_EP0_CTRL; that moves data to/from the driver's DMA buffer and completes
> the parked packet back to the host.
> 
> SET_ADDRESS is the exception: it is applied synchronously, because the host
> controller keeps the transfer bound to address 0 until it completes.
> 
> The gadget connects to / disconnects from the host bus when the driver
> sets or clears the upstream-enable (pull-up) bit, and is detached on reset.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/usb/aspeed-udc.h |  28 +++
>   hw/usb/aspeed-udc.c         | 382 +++++++++++++++++++++++++++++++++++-
>   hw/usb/trace-events         |   5 +
>   3 files changed, 412 insertions(+), 3 deletions(-)

QOM/QDev:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

