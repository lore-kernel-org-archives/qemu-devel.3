Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42C9C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 13:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOdYK-00052d-WB; Tue, 02 Jul 2024 09:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOdY0-0004T7-Px
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOdXx-000648-6n
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719926859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OI3SQjO8oKecLfrujZynADgw/+u+14uf1pGNOZLpwmE=;
 b=bm8Pu0sMCTdklfx+/5DEs52jHezH0vC+DZijMfAtRJyPASFAlkJ5/gNbL+XsfmdEmAoPKq
 ryVQ+0GBGB6hC0HHQrEzeOzOKY9NEm6H7zCiexofMPSizYVBCjk3eydOVJ63nwMpPZntjK
 0BGoTF42RrgDqN57H6TJ2uYrNOssDL4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-xVp9pSAiOlWfIkS2izJK0w-1; Tue, 02 Jul 2024 09:27:38 -0400
X-MC-Unique: xVp9pSAiOlWfIkS2izJK0w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a726756c8a2so375569366b.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 06:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719926854; x=1720531654;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OI3SQjO8oKecLfrujZynADgw/+u+14uf1pGNOZLpwmE=;
 b=tgJNytCh2HLJbVdxmPeyDKuj2jqwkcznFZ8ezra9wDbE7EJubwStmLvJ/5ByGSgImh
 z/SdIC4pDBkpUMn7y1y/B2Vj2hWsibMCPKx0hI2RqXb4viNRq/Koklq1rSVcZQOBllqH
 f7BAiKI4FYspievRcm9IZ8OnAgqjzYQntwbaEYPYGAq1HA8kHdm8ybgLZb578D/Skb5J
 WNwMS0hJqsXe3wq6xp4vSu6MnArcpU4y/x+teQDLNkjreRcIaC+/6k8e7lQb5u012bQN
 svFe2wLjLfHYN1hoeZHp72XnX+DLPgx/blNLDsh/9bPQEc3gXGNX/3hWmE7CP1H7aim0
 NRhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDGOfBoq/CfnFtrHxB+Wz/IONaMUT1RrV+N6jxcO5b3qGJfF8vklqAYR/kOR3QZlwtrOwphc2EpjrMaPm8h3UgoTq3ll8=
X-Gm-Message-State: AOJu0Yz/P6d6+Ebvo1kHERG7lFIW09Q2YHyUgOaWtGWI5oosQa4LJn8p
 n05DAOC0AEI66BoMnOKSeGRVB0YDfMfaIk7XrSnrK5U5ReZhGxyMuEuYS6FPbT9juDLFlkRcZ+4
 5v8sFH4S8pOg7yMt7Bu27UeDM6lpHOscJvnHCzkXoHLpjwAZrjjlf
X-Received: by 2002:a17:906:730c:b0:a75:3c2d:cd90 with SMTP id
 a640c23a62f3a-a753c2dd1f3mr248777266b.65.1719926853927; 
 Tue, 02 Jul 2024 06:27:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZBpTBUzZE/ZcdTygjHrH96dJwX9okv+LPU2GDk3Wn7cPg78hsnxA6Z9GGS6etXk7fXUiW+Q==
X-Received: by 2002:a17:906:730c:b0:a75:3c2d:cd90 with SMTP id
 a640c23a62f3a-a753c2dd1f3mr248772666b.65.1719926853012; 
 Tue, 02 Jul 2024 06:27:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:614d:9fb:6fdd:72a4:f3d])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0901a2sm418450466b.182.2024.07.02.06.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 06:27:32 -0700 (PDT)
Date: Tue, 2 Jul 2024 09:27:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: wilfred.mallawa@wdc.com, marcel.apfelbaum@gmail.com, lukas@wunner.de,
 qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 kbusch@kernel.org, hchkuo@avery-design.com.tw,
 cbrowy@avery-design.com, its@irrelevant.dk, jiewen.yao@intel.com,
 Alistair Francis <alistair.francis@wdc.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v7 3/3] hw/nvme: Add SPDM over DOE support
Message-ID: <20240702092450-mutt-send-email-mst@kernel.org>
References: <20240614012846.1016856-1-alistair.francis@wdc.com>
 <20240614012846.1016856-4-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614012846.1016856-4-alistair.francis@wdc.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 14, 2024 at 11:28:46AM +1000, Alistair Francis wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Setup Data Object Exchance (DOE) as an extended capability for the NVME
> controller and connect SPDM to it (CMA) to it.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Klaus Jensen <k.jensen@samsung.com>


With this, qos-test fails:

# Start of nvme-tests tests
# starting QEMU: exec ./build/qemu-system-x86_64 -qtest unix:/tmp/qtest-72968.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-72968.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -M pc  -drive id=drv0,if=none,file=null-co://,file.read-zeroes=on,format=raw -object memory-backend-ram,id=pmr0,share=on,size=8 -device nvme,addr=04.0,drive=drv0,serial=foo,cmb_size_mb=2 -accel qtest
ok 27 /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/nvme/nvme-tests/oob-cmb-access
# starting QEMU: exec ./build/qemu-system-x86_64 -qtest unix:/tmp/qtest-72968.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-72968.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -M pc  -drive id=drv0,if=none,file=null-co://,file.read-zeroes=on,format=raw -object memory-backend-ram,id=pmr0,share=on,size=8 -device nvme,addr=04.0,drive=drv0,serial=foo,pmrdev=pmr0 -accel qtest
Broken pipe
../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
./run4bisect.sh: line 30: 72968 Aborted                 (core dumped) QTEST_QEMU_STORAGE_DAEMON_BINARY=./build/storage-daemon/qemu-storage-daemon QTEST_QEMU_BINARY=./build/qemu-system-x86_64 ./build/tests/qtest/qos-test
TEST DONE 1


Also here:

https://gitlab.com/mstredhat/qemu/-/jobs/7245683487


I dropped the patchset for now, pls resolve and resubmit.




> ---
>  docs/specs/index.rst        |   1 +
>  docs/specs/spdm.rst         | 134 ++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pci_device.h |   7 ++
>  include/hw/pci/pcie_doe.h   |   3 +
>  hw/nvme/ctrl.c              |  60 ++++++++++++++++
>  5 files changed, 205 insertions(+)
>  create mode 100644 docs/specs/spdm.rst
> 
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 1484e3e760..e2d907959a 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -29,6 +29,7 @@ guest hardware that is specific to QEMU.
>     edu
>     ivshmem-spec
>     pvpanic
> +   spdm
>     standard-vga
>     virt-ctlr
>     vmcoreinfo
> diff --git a/docs/specs/spdm.rst b/docs/specs/spdm.rst
> new file mode 100644
> index 0000000000..f7de080ff0
> --- /dev/null
> +++ b/docs/specs/spdm.rst
> @@ -0,0 +1,134 @@
> +======================================================
> +QEMU Security Protocols and Data Models (SPDM) Support
> +======================================================
> +
> +SPDM enables authentication, attestation and key exchange to assist in
> +providing infrastructure security enablement. It's a standard published
> +by the `DMTF`_.
> +
> +QEMU supports connecting to a SPDM responder implementation. This allows an
> +external application to emulate the SPDM responder logic for an SPDM device.
> +
> +Setting up a SPDM server
> +========================
> +
> +When using QEMU with SPDM devices QEMU will connect to a server which
> +implements the SPDM functionality.
> +
> +SPDM-Utils
> +----------
> +
> +You can use `SPDM Utils`_ to emulate a responder. This is the simplest method.
> +
> +SPDM-Utils is a Linux applications to manage, test and develop devices
> +supporting DMTF Security Protocol and Data Model (SPDM). It is written in Rust
> +and utilises libspdm.
> +
> +To use SPDM-Utils you will need to do the following steps. Details are included
> +in the SPDM-Utils README.
> +
> + 1. `Build libspdm`_
> + 2. `Build SPDM Utils`_
> + 3. `Run it as a server`_
> +
> +spdm-emu
> +--------
> +
> +You can use `spdm emu`_ to model the
> +SPDM responder.
> +
> +.. code-block:: shell
> +
> +    $ cd spdm-emu
> +    $ git submodule init; git submodule update --recursive
> +    $ mkdir build; cd build
> +    $ cmake -DARCH=x64 -DTOOLCHAIN=GCC -DTARGET=Debug -DCRYPTO=openssl ..
> +    $ make -j32
> +    $ make copy_sample_key # Build certificates, required for SPDM authentication.
> +
> +It is worth noting that the certificates should be in compliance with
> +PCIe r6.1 sec 6.31.3. This means you will need to add the following to
> +openssl.cnf
> +
> +.. code-block::
> +
> +    subjectAltName = otherName:2.23.147;UTF8:Vendor=1b36:Device=0010:CC=010802:REV=02:SSVID=1af4:SSID=1100
> +    2.23.147 = ASN1:OID:2.23.147
> +
> +and then manually regenerate some certificates with:
> +
> +.. code-block:: shell
> +
> +    $ openssl req -nodes -newkey ec:param.pem -keyout end_responder.key \
> +        -out end_responder.req -sha384 -batch \
> +        -subj "/CN=DMTF libspdm ECP384 responder cert"
> +
> +    $ openssl x509 -req -in end_responder.req -out end_responder.cert \
> +        -CA inter.cert -CAkey inter.key -sha384 -days 3650 -set_serial 3 \
> +        -extensions v3_end -extfile ../openssl.cnf
> +
> +    $ openssl asn1parse -in end_responder.cert -out end_responder.cert.der
> +
> +    $ cat ca.cert.der inter.cert.der end_responder.cert.der > bundle_responder.certchain.der
> +
> +You can use SPDM-Utils instead as it will generate the correct certificates
> +automatically.
> +
> +The responder can then be launched with
> +
> +.. code-block:: shell
> +
> +    $ cd bin
> +    $ ./spdm_responder_emu --trans PCI_DOE
> +
> +Connecting an SPDM NVMe device
> +==============================
> +
> +Once a SPDM server is running we can start QEMU and connect to the server.
> +
> +For an NVMe device first let's setup a block we can use
> +
> +.. code-block:: shell
> +
> +    $ cd qemu-spdm/linux/image
> +    $ dd if=/dev/zero of=blknvme bs=1M count=2096 # 2GB NNMe Drive
> +
> +Then you can add this to your QEMU command line:
> +
> +.. code-block:: shell
> +
> +    -drive file=blknvme,if=none,id=mynvme,format=raw \
> +        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323
> +
> +At which point QEMU will try to connect to the SPDM server.
> +
> +Note that if using x64-64 you will want to use the q35 machine instead
> +of the default. So the entire QEMU command might look like this
> +
> +.. code-block:: shell
> +
> +    qemu-system-x86_64 -M q35 \
> +        --kernel bzImage \
> +        -drive file=rootfs.ext2,if=virtio,format=raw \
> +        -append "root=/dev/vda console=ttyS0" \
> +        -net none -nographic \
> +        -drive file=blknvme,if=none,id=mynvme,format=raw \
> +        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323
> +
> +.. _DMTF:
> +   https://www.dmtf.org/standards/SPDM
> +
> +.. _SPDM Utils:
> +   https://github.com/westerndigitalcorporation/spdm-utils
> +
> +.. _spdm emu:
> +   https://github.com/dmtf/spdm-emu
> +
> +.. _Build libspdm:
> +   https://github.com/westerndigitalcorporation/spdm-utils?tab=readme-ov-file#build-libspdm
> +
> +.. _Build SPDM Utils:
> +   https://github.com/westerndigitalcorporation/spdm-utils?tab=readme-ov-file#build-the-binary
> +
> +.. _Run it as a server:
> +   https://github.com/westerndigitalcorporation/spdm-utils#qemu-spdm-device-emulation
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index d3dd0f64b2..15694f2489 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -3,6 +3,7 @@
>  
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pcie.h"
> +#include "hw/pci/pcie_doe.h"
>  
>  #define TYPE_PCI_DEVICE "pci-device"
>  typedef struct PCIDeviceClass PCIDeviceClass;
> @@ -157,6 +158,12 @@ struct PCIDevice {
>      MSIVectorReleaseNotifier msix_vector_release_notifier;
>      MSIVectorPollNotifier msix_vector_poll_notifier;
>  
> +    /* SPDM */
> +    uint16_t spdm_port;
> +
> +    /* DOE */
> +    DOECap doe_spdm;
> +
>      /* ID of standby device in net_failover pair */
>      char *failover_pair_id;
>      uint32_t acpi_index;
> diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
> index 15d94661f9..9e1275db8a 100644
> --- a/include/hw/pci/pcie_doe.h
> +++ b/include/hw/pci/pcie_doe.h
> @@ -108,6 +108,9 @@ struct DOECap {
>      /* Protocols and its callback response */
>      DOEProtocol *protocols;
>      uint16_t protocol_num;
> +
> +    /* Used for spdm-socket */
> +    int spdm_socket;
>  };
>  
>  void pcie_doe_init(PCIDevice *pdev, DOECap *doe_cap, uint16_t offset,
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..db41f7c8d0 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -203,6 +203,7 @@
>  #include "sysemu/hostmem.h"
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pcie_sriov.h"
> +#include "sysemu/spdm-socket.h"
>  #include "migration/vmstate.h"
>  
>  #include "nvme.h"
> @@ -8087,6 +8088,27 @@ static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
>      return 0;
>  }
>  
> +static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
> +{
> +    void *req = pcie_doe_get_write_mbox_ptr(doe_cap);
> +    uint32_t req_len = pcie_doe_get_obj_len(req) * 4;
> +    void *rsp = doe_cap->read_mbox;
> +    uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
> +
> +    uint32_t recvd = spdm_socket_rsp(doe_cap->spdm_socket,
> +                             SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE,
> +                             req, req_len, rsp, rsp_len);
> +    doe_cap->read_mbox_len += DIV_ROUND_UP(recvd, 4);
> +
> +    return recvd != 0;
> +}
> +
> +static DOEProtocol doe_spdm_prot[] = {
> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_spdm_rsp },
> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_SECURED_CMA, pcie_doe_spdm_rsp },
> +    { }
> +};
> +
>  static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
>  {
>      ERRP_GUARD();
> @@ -8157,6 +8179,25 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
>  
>      nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
>  
> +    pcie_cap_deverr_init(pci_dev);
> +
> +    /* DOE Initialisation */
> +    if (pci_dev->spdm_port) {
> +        uint16_t doe_offset = n->params.sriov_max_vfs ?
> +                                  PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZEOF
> +                                  : PCI_CONFIG_SPACE_SIZE;
> +
> +        pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset,
> +                      doe_spdm_prot, true, 0);
> +
> +        pci_dev->doe_spdm.spdm_socket = spdm_socket_connect(pci_dev->spdm_port,
> +                                                            errp);
> +
> +        if (pci_dev->doe_spdm.spdm_socket < 0) {
> +            return false;
> +        }
> +    }
> +
>      if (n->params.cmb_size_mb) {
>          nvme_init_cmb(n, pci_dev);
>      }
> @@ -8407,6 +8448,11 @@ static void nvme_exit(PCIDevice *pci_dev)
>          g_free(n->cmb.buf);
>      }
>  
> +    if (pci_dev->doe_spdm.spdm_socket > 0) {
> +        spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
> +                          SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE);
> +    }
> +
>      if (n->pmr.dev) {
>          host_memory_backend_set_mapped(n->pmr.dev, false);
>      }
> @@ -8451,6 +8497,7 @@ static Property nvme_props[] = {
>                        params.sriov_max_vq_per_vf, 0),
>      DEFINE_PROP_BOOL("msix-exclusive-bar", NvmeCtrl, params.msix_exclusive_bar,
>                       false),
> +    DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -8522,11 +8569,23 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
>  {
>      uint16_t old_num_vfs = pcie_sriov_num_vfs(dev);
>  
> +    pcie_doe_write_config(&dev->doe_spdm, address, val, len);
>      pci_default_write_config(dev, address, val, len);
>      pcie_cap_flr_write_config(dev, address, val, len);
>      nvme_sriov_post_write_config(dev, old_num_vfs);
>  }
>  
> +static uint32_t nvme_pci_read_config(PCIDevice *dev, uint32_t address, int len)
> +{
> +    uint32_t val;
> +    if (dev->spdm_port) {
> +        if (pcie_doe_read_config(&dev->doe_spdm, address, len, &val)) {
> +            return val;
> +        }
> +    }
> +    return pci_default_read_config(dev, address, len);
> +}
> +
>  static const VMStateDescription nvme_vmstate = {
>      .name = "nvme",
>      .unmigratable = 1,
> @@ -8539,6 +8598,7 @@ static void nvme_class_init(ObjectClass *oc, void *data)
>  
>      pc->realize = nvme_realize;
>      pc->config_write = nvme_pci_write_config;
> +    pc->config_read = nvme_pci_read_config;
>      pc->exit = nvme_exit;
>      pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
>      pc->revision = 2;
> -- 
> 2.45.2


