Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C548CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 13:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoMI1-0005XR-Vj; Tue, 19 Aug 2025 09:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uoMHu-0005Wc-Iy
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 09:22:08 -0400
Received: from p-east1-cluster3-host9-snip4-3.eps.apple.com ([57.103.91.214]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uoMHs-0000nG-Sr
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 09:22:06 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-1 (Postfix) with ESMTPS id
 46CDA1800223; Tue, 19 Aug 2025 13:22:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=CdhKC+5IRorrZAK3611ZzOgZ9jDP7nS5VaEZFEuI+BM=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=YZ0V7Ixwb5sdfiCl9nr8HlkD9+EM93geY+ALsxyaIzklyPNC81a4RhXpAkCUn5birHKfE1ZmIJhWc8rYOLWQzfFqlIYztmcvrgP0W+VXePz1UlWv9GDDFXHucEGVe0b/3Nq5C7OUd9XtrScpU7RLbkoY5VHd3DXe2VggoC5iLbCz44tUOI3IN290jK2XUurHg1icFc2R5LkKZhek19G9oXLeZLI1W64sXn9R01Aj56GPALfk391hjZCYSoPFlUG+DRBPI6JwQgNPIITekigXvZj7NFe/UQzAX4YMWhprppCKExzFStHsMWZRmIXhLEZsePxZvrwiHhZ2FK6O9Xb0ag==
X-Client-IP: 194.62.217.67
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-1 (Postfix) with ESMTPSA id
 4AE941801308; Tue, 19 Aug 2025 13:21:59 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 04/13] hw/intc: Add hvf vGIC interrupt controller
 support
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20832F49-1F5C-4023-9E0C-0D51A87A1770@unpredictable.fr>
Date: Tue, 19 Aug 2025 15:21:47 +0200
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>
Content-Transfer-Encoding: 7bit
Message-Id: <62C5CA36-E0DB-48DA-96D9-74EA5794ACC8@ynddal.dk>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
 <20250808070137.48716-5-mohamed@unpredictable.fr>
 <40259CA2-A38D-41C1-A726-5144FB9EA166@ynddal.dk>
 <20832F49-1F5C-4023-9E0C-0D51A87A1770@unpredictable.fr>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-ORIG-GUID: pnrck2MjLpoiauWvjBIGs-jqP5Cxhh4n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDEyNSBTYWx0ZWRfX/JCEZUd98/qx
 jdUPqNLzDMOAPstZjE4lrzDN3+z/ttJTwAO8brRqML/fIXFExBGikpltQbKFV+gsu3KczCRW5D2
 s4GVUnpk6r3vKNc7i/U3PB15rtCGsiop3QBrUDHUKosjU+0wgpocMHBK1XUj6lqDw1R9Ai2RJbW
 4bcEYv7RDUUjhBWFakTG65MgBZrmKtYJBOm0mgOJCHeImojF8GA38jPdqTvSfzRLrLSatFf92qJ
 3Mzc3sHD+/6nquDv8ORYNBOrN9hieX6rQWAQKJYSYHFpGHUkRxwU1wlywdRBik0QZsloHy5n4=
X-Proofpoint-GUID: pnrck2MjLpoiauWvjBIGs-jqP5Cxhh4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=860
 adultscore=0 clxscore=1030 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508190125
X-JNJ: AAAAAAAB9p+5CO/Av3JkYhTudQ3GjXQADrQApyG5uXnEQX5uRS8nzy2yGJw4iBaX2zurYkujfquG5tELRT44AG54nqBSYniTttGm4qJ8TivUy72YD+ZSb8DDQ9Z3Vt65ilZqX5Pn96aa17Qr241kopsu0MgZRKTKu/M+opZ5qwOQgVDHG+IJObei7pKmjcx6u/tkkQO+K77lc4wX720AdRzUSMuZz6ANUgYJYWX2KLs49sf3WjXdNvAeyLp4NfW2D4XkFiSvVRAAYLpT31qf2WRhBkZ1BqhfdaGY2vwXaxG1QlgVI4Jp7XEm79c10tjnbg87oMWdZ+oWsfQ/Ry/+/Ts3uJhRmK8y59d3TDL7eEtpNAq7px0EYkAa8dZIilEUirZpvQvwI4AbbAbBSY1mxthq/B3RpfVRSW9D6LMyhelzLmcj5zjYPb88U3DuIkbSOM7JT7CIs4a8gTS6IHL5Sql++I+7VaBKs5NG5YU2104oMpMmZJKwKnk5+l4wD2UjvZEaX+aSj4JY76FBok3Ms/znfR0qtdD4nDNAAGiIU0zJ2PG3rlKIpmEPfBiBGjpfLy9vlpagPrXOjuZPsD6JqF6jekqlWQ==
Received-SPF: pass client-ip=57.103.91.214; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


> On which chip/macOS release did you see this failure?

This was on Apple M3 Pro. Must have been macOS 15.6.

