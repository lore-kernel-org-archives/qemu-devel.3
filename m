Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D07CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOoP-0000zG-7i; Sun, 04 Oct 2026 12:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mahesh@linux.ibm.com>)
 id 1xDOLC-0001kn-4Z; Sun, 04 Oct 2026 11:41:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mahesh@linux.ibm.com>)
 id 1xDOLA-00076R-17; Sun, 04 Oct 2026 11:41:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 694F5Yx5915711; Sun, 4 Oct 2026 15:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:reply-to:subject:to; s=pp1; bh=/MP3XVnbeeq27k049XgJK
 DOzlDaAwTHNLntpWHI6gQY=; b=bErbzI7zwq7NJPNBW7dLXulWgsXVpowW0O/fK
 pgP3u0HHLlNeUKkc3aBApFh+WcVk8Q7rF1Srlif9U4DGscBRUAk03TNta0FXwP1m
 iEA827rfrFnEngP32+vxN4JPxTNdtOyM6XAzHSBYe2ydv6BX5Ev++wkU6UykVC0n
 xL5oa157B8+t6t6c3MQaD/d7smK/BG2K2jYJetdxP3pFvLiL0xDSzyiKpJnkbdol
 9Ch3jNC5YRtgW/G5KQr8u7b3QRBKw1Y3Aie2YJYFxxyDxeehuPYMxsc5E4Z9whak
 3FAa8PpL9egqfd9eEVFdkfq4qSwaPWbkgJqV/HBLnG533PJ9w==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fnrmk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 04 Oct 2026 15:41:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 694ElfcI1519007; Sun, 4 Oct 2026 15:41:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pj3c5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 04 Oct 2026 15:41:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 694FfIi129164224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 4 Oct 2026 15:41:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FADC2004B;
 Sun,  4 Oct 2026 15:41:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4A3320040;
 Sun,  4 Oct 2026 15:41:15 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.216.153])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sun,  4 Oct 2026 15:41:15 +0000 (GMT)
Date: Sun, 4 Oct 2026 21:11:12 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sbhat@linux.ibm.com,
 sourabhjain@linux.ibm.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, adityag@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com
Subject: Re: [PATCH v1 2/2] ppc/spapr: Temporarily disable VFIO BAR mmap
 during EEH PE reset
Message-ID: <asJlgfvC0UfgPWKd@linux.ibm.com>
References: <20260902114758.85160-1-nnmlinux@linux.ibm.com>
 <20260902114758.85160-3-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902114758.85160-3-nnmlinux@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac273a4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=iaxHRrBpKBgXuYGtksMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA0MDA2MiBTYWx0ZWRfX4pYXarrMxCTw
 KRGjhpKYXBqYs3jymRFWMhi9R5B2qLDoyb+pRJ1k+ZGcd0Ns8hknLerlAVcBJpaVhEMs2NAZo8t
 e72Sepa90xWcvmH32BMM/RVH6r5xS5sw4/JBI466jwfpfNxqAFpTCuNH0LmgIRAW9Xyt+rYuwVo
 oTrpDSx5oMT3RslFVuWW24kiVfegDa3mKM4h86YVhwYi4Ay894TZBkJpKw3Ah6YFUQag9wRa9lF
 lGGgmqpjbakIUbTASPEHU0FgIOpHujwoFKfd3fUMBAXkvwlHE95xxtLZusJ5itFrw8Vc+di3DI4
 YP1qVaMIZvOC5voappDfsQJJpy5OKsWYsvzg26E/LoJ/njMOlx3trXfZJJOIHnKW0mDNV++S+IP
 1yCJNnk6F1LDSOqVw8bO8/+fC4ySSglsZ5q3SoJ5oPvgdqvLcIBoMQgCLu1bQyUaXtT11VKJTwZ
 j2BXzHa+0Dpnr7BBViA==
X-Proofpoint-GUID: Bf2el-0gWTiJSbTOLOSiqV5_UhnbIXXn
X-Proofpoint-ORIG-GUID: fgzFe7IM0xCoAp-5OzAFuudcoeNegLfR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA0MDA2MiBTYWx0ZWRfXzmJOMc0uJNh4
 wSJ88WGUxhf4tGy4iVJ0nHBWa2lwFcZ/YNBZR2B2qR48j8GJX9fN0VJ64DpExY2rQhe/OGYJyT+
 sW/edIhwVf980UKfSdZZtrPHfvGW9lk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-04_04,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610040062
Received-SPF: pass client-ip=148.163.158.5; envelope-from=mahesh@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 04 Oct 2026 12:11:24 -0400
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
Reply-To: mahesh@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-09-02 17:17:58 Wed, Narayana Murty N wrote:
> An EEH PE hot or fundamental reset involves a synchronous kernel ioctl
> (VFIO_EEH_PE_RESET_HOT / VFIO_EEH_PE_RESET_FUNDAMENTAL) that asserts
> then de-asserts a PCI reset signal to the endpoint.  During this window
> the device's BARs are inaccessible, but QEMU may still have those BARs
> memory-mapped for direct guest access.  A guest MMIO fault that arrives
> while the hardware is in reset can cause an unexpected host kernel page
> fault or an indeterminate read value.
> 
> Fix this by disabling the BAR mmap windows for every VFIO PCI device
> under the PHB before issuing the PE reset ioctl, and re-enabling them
> after VFIO_EEH_PE_CONFIGURE succeeds.
> 
> A new spapr_phb_vfio_eeh_post_configure() bus walker calls
> vfio_region_mmaps_set_enabled(..., true) on the configure success
> path inside spapr_phb_vfio_eeh_configure().  On failure the mmaps
> remain disabled; the next EEH reset attempt will call pre_reset
> again.
> 
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>  hw/ppc/spapr_pci_vfio.c | 68 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
> index c233822d14..1cf058cbde 100644
> --- a/hw/ppc/spapr_pci_vfio.c
> +++ b/hw/ppc/spapr_pci_vfio.c
> @@ -252,17 +252,28 @@ int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
>   * pci_host_config_write_common() so that the VFIO config-write handler calls
>   * vfio_msix_disable(), cleanly releasing vectors and KVM irqfd routes while
>   * leaving the shadow intact.
> + *
> + * After disabling interrupts, disable BAR mmap windows so that the host
> + * kernel PE reset ioctl does not race with QEMU direct-mapped guest accesses.
> + * The timer that would ordinarily re-enable mmaps after an INTx quiet period
> + * is cancelled here; mmaps are restored after VFIO_EEH_PE_CONFIGURE succeeds
> + * in spapr_phb_vfio_eeh_configure().
>   */
>  static void spapr_phb_vfio_eeh_prepare_dev(PCIBus *bus,
>                                             PCIDevice *pdev,
>                                             void *opaque)
>  {
> +    VFIOPCIDevice *vdev;
>      uint16_t flags;
> +    int i;
>  
>      if (!object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI_DEVICE)) {
>          return;
>      }
>  
> +    vdev = VFIO_PCI_DEVICE(pdev);
> +
> +    /* Step 1: disable MSI-X without wiping the shadow table (see above). */
>      if (msix_enabled(pdev)) {
>          flags = pci_get_word(pdev->config + pdev->msix_cap + PCI_MSIX_FLAGS);
>          flags &= ~PCI_MSIX_FLAGS_ENABLE;
> @@ -270,6 +281,19 @@ static void spapr_phb_vfio_eeh_prepare_dev(PCIBus *bus,
>                                       pdev->msix_cap + PCI_MSIX_FLAGS,
>                                       pci_config_size(pdev), flags, 2);
>      }
> +
> +    /*
> +     * Step 2: cancel any pending INTx mmap re-enable timer.  The timer is
> +     * only allocated when PCI_INTERRUPT_PIN is non-zero, so guard the call.
> +     */
> +    if (vdev->intx.mmap_timer) {
> +        timer_del(vdev->intx.mmap_timer);
> +    }
> +
> +    /* Step 3: disable BAR mmaps last, after interrupt teardown. */
> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> +        vfio_region_mmaps_set_enabled(&vdev->bars[i].region, false);
> +    }

Maybe you can add a small helper in something like
vfio_eeh_pci_pre_reset(pdev) in hw/vfio/pci.c to include step 2 and 3 ?
That way VFIOPCIDevice internals can be hidden under the helper.

>  }
>  
>  static void spapr_phb_vfio_eeh_prepare_bus(PCIBus *bus, void *opaque)
> @@ -286,6 +310,43 @@ static void spapr_phb_vfio_eeh_pre_reset(SpaprPhbState *sphb)
>      pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_prepare_bus, NULL);
>  }
>  
> +/*
> + * Re-enable BAR mmap windows for a single VFIO PCI device after a successful
> + * EEH PE configure.  Called only on the configure success path; on failure the
> + * mmaps remain disabled until the next hot/fundamental reset attempt.
> + */
> +static void spapr_phb_vfio_eeh_post_configure_dev(PCIBus *bus,
> +                                                   PCIDevice *pdev,
> +                                                   void *opaque)
> +{
> +    VFIOPCIDevice *vdev;
> +    int i;
> +
> +    if (!object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI_DEVICE)) {
> +        return;
> +    }
> +
> +    vdev = VFIO_PCI_DEVICE(pdev);
> +
> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> +        vfio_region_mmaps_set_enabled(&vdev->bars[i].region, true);
> +    }

Same here.

Also, what about the mmap timer ? Does that get re-armed when INTx is
re-initialsed during EEH recovery and hence we ignore here ?

> +}
> +
> +static void spapr_phb_vfio_eeh_post_configure_bus(PCIBus *bus, void *opaque)
> +{
> +    pci_for_each_device_under_bus(bus,
> +                                  spapr_phb_vfio_eeh_post_configure_dev,
> +                                  NULL);
> +}
> +
> +static void spapr_phb_vfio_eeh_post_configure(SpaprPhbState *sphb)
> +{
> +    PCIHostState *phb = PCI_HOST_BRIDGE(sphb);
> +
> +    pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_post_configure_bus, NULL);
> +}
> +
>  int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
>  {
>      uint32_t op;
> @@ -293,6 +354,11 @@ int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
>  
>      switch (option) {
>      case RTAS_SLOT_RESET_DEACTIVATE:
> +        /*
> +         * Deactivate does not perform a full PE reset; BAR mmaps were already
> +         * disabled by the preceding HOT or FUNDAMENTAL reset call and must not
> +         * be re-enabled here.
> +         */
>          op = VFIO_EEH_PE_RESET_DEACTIVATE;
>          break;
>      case RTAS_SLOT_RESET_HOT:
> @@ -324,6 +390,8 @@ int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
>          return RTAS_OUT_PARAM_ERROR;
>      }
>  
> +    spapr_phb_vfio_eeh_post_configure(sphb);
> +
>      return RTAS_OUT_SUCCESS;
>  }


Thanks,
-Mahesh.

-- 
Mahesh J Salgaonkar

