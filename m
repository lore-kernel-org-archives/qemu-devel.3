Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C95CC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 11:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvFX4-000791-Jh; Fri, 12 Apr 2024 07:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1rvFX0-00078M-Of
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:57:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1rvFWy-0006VR-AM
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:57:21 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43C9cWrR029271; Fri, 12 Apr 2024 11:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=19UPu1SFcjPeTQB85TJu8elqeQYkWXfAil3hPDGBqEQ=; b=ki
 1aHtoalVvIZI3DBKzblvDAOmoopyPTVcCOHVaXm0zIaCu7dAXraWwKUnnxUqslNX
 +zpNwPhIyfr/QMk4CvO/oebgeu1yNRSfK1CH01lTnFKeThMRP1EsQ60iQPY/vtzG
 8sm5EmtkqjbpgkcZ2X9BNSd0XtwiYCgc1qloBczfqSSN3I3RUtpgp9o1KWh8QVzz
 6guKM/oNR2afMmojVenroaw1kxEn7j8tXkrSirR0CvAsZPLiFaF6sOLwXZKYwQcv
 rY5imQuhFi4f3qcaYIoOd3g9xt6XJ6EDH3LLtXeJAOTaUSC1ZLflFPEH0NovjqBc
 AnDlpX3AMLb8Z7ZOYv7Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xeskt1b4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Apr 2024 11:57:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CBv3dY028155
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Apr 2024 11:57:03 GMT
Received: from mathbern-mac.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 12 Apr 2024 04:57:00 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>, <martin@geanix.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] Makefile: fix use of -j without an argument
Date: Fri, 12 Apr 2024 08:56:19 -0300
Message-ID: <20240412115641.48850-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <CABgObfa5NVGTTC_D09tomXf6FhYnbCt6wY_K_L32cWLXOhaJgg@mail.gmail.com>
References: <CABgObfa5NVGTTC_D09tomXf6FhYnbCt6wY_K_L32cWLXOhaJgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 1NzgO2yOGAwhaeKTV8gWgJDheuhrx5oX
X-Proofpoint-ORIG-GUID: 1NzgO2yOGAwhaeKTV8gWgJDheuhrx5oX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=714 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404120086
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, 12 Apr 2024 10:02:54 +0200 Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Thu, Apr 11, 2024 at 5:46 PM Matheus Tavares Bernardino
> <quic_mathbern@quicinc.com> wrote:
> > +        $(if $(filter -j, $(MAKEFLAGS)) \
> > +            ,, \
> > +            $(or \
> > +                 $(filter -l% -j%, $(MAKEFLAGS)), \
> > +                 $(if $(filter --jobserver-auth=%, $(MAKEFLAGS)),, -j1)) \
> > +        ) -d keepdepfile
> 
> This is more easily written as $(filter-out -j, $(or ...)).
> 
> I've sent a v2.

Thanks! 

